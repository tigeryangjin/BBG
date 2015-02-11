#! /bin/ksh

#-------------------------------------------------------------------------
#  File:  cmx_rpm_delete_bulk_cc.ksh
#
#  Desc:  
#-------------------------------------------------------------------------
#set -x

pgmName=`basename $0`
pgmName=${pgmName##*/}    # remove the path
pgmExt=${pgmName##*.}     # get the extension
pgmName=${pgmName%.*}     # get the program name
pgmPID=$$                 # get the process ID
exeDate=`date +"%h_%d"`   # get the execution date

LOGFILE="${MMHOME}/log/$exeDate.log"
ERRORFILE="${MMHOME}/error/err.$pgmName."$exeDate
ERRINDFILE=21.err.ind
FATAL=255
NON_FATAL=1
OK=0
TRUE=1
FALSE=0


USAGE="Usage: $pgmName.$pgmExt <connect> \n"

function LOG_MESSAGE
{
   logMsg=`echo $1`       # echo message to a single line
   logFunc=$2
   retCode=$3

   dtStamp=`date +"%a %b %e %T"`
   echo "$dtStamp Program: $pgmName: PID=$pgmPID: $logMsg $logFunc" >> $LOGFILE

   return $retCode
}

function LOG_ERROR
{
   errMsg=`echo $1`       # echo message to a single line
   errFunc=$2
   retCode=$3

   dtStamp=`date +"%G%m%d%H%M%S"`
   echo "$pgmName~$dtStamp~$errFunc~$errMsg" >> $ERRORFILE
   if [[ $retCode -eq ${FATAL} ]]; then
      LOG_MESSAGE "Aborted in" $errFunc $retCode
   fi

   return $retCode
}

function CHK_DIR
{
   dirPath=$1
   inout=$2

   # Check if path is valid
   if [[ $inout = 'src' && -d $dirPath && -r $dirPath ]]; then
      :
   elif [[ $inout = 'dmp' && -d $dirPath && -w $dirPath ]]; then
      :
   else
      LOG_ERROR "$dirPath directory is invalid or path is not accessible." "CHK_DIR" ${FATAL}
      exit ${FATAL}
   fi

   return ${OK}
}

function CHK_IN_FILES
{
   dirPath=$1

   if [[ -n `ls -1 ${dirPath} 2>/dev/null` ]]; then
      echo ${TRUE}
   else
      echo ${FALSE}
   fi

   return ${OK}

}

function LOAD_FILES
{
   for dataFile in `ls ${inputDir}/wf*.dat 2>/dev/null`
   do
      while [ `jobs | wc -l` -ge $SLOTS ]
      do
         : # Null command.
      done

      dtStamp=`date +"%G%m%d%H%M%S"`
      sqlldrFile=${dataFile##*/}
      sqlldr ${connectStr} silent=feedback,header control=${CTLFILE} log=${outputDir}/$sqlldrFile.${dtStamp} data=${dataFile} bad=${outputDir}/$sqlldrFile.bad discard=${outputDir}/$sqlldrFile.dsc &

   done;
   
   wait
   
   LOG_MESSAGE "Completed file load to staging"

   return ${OK}

}


function EXEC_SQL
{
   sqlTxt=$*

   sqlReturn=`echo "set feedback off;
      set heading off;
      set term off;
      set verify off;
      set serveroutput on size 1000000;

      VARIABLE GV_return_code    NUMBER;
      VARIABLE GV_script_error   CHAR(255);

      EXEC :GV_return_code  := 0;
      EXEC :GV_script_error := NULL;

      WHENEVER SQLERROR EXIT ${FATAL}
      $sqlTxt
      /

      print :GV_script_error;
      exit  :GV_return_code;
      " | sqlplus -s ${connectStr}`

   if [[ $? -ne ${OK} ]]; then
      LOG_ERROR "${sqlReturn}" "EXEC_SQL" ${FATAL}
      return ${FATAL}
   fi

   return ${OK}
}

function RA_BATCH_CHECK
{
   threadVal=$1
   sqlTxt="
      DECLARE
         L_str_error_tst   VARCHAR2(1) := NULL;
         FUNCTION_ERROR    EXCEPTION;
      BEGIN
         if NOT CMX_RA_BATCH_CHECK_SQL.fact_main(:GV_script_error) then
            raise FUNCTION_ERROR;
         end if;

         COMMIT;
      EXCEPTION
         when FUNCTION_ERROR then
            ROLLBACK;
            :GV_return_code := ${FATAL};
         when OTHERS then
            ROLLBACK;
            :GV_script_error := SQLERRM;
            :GV_return_code := ${FATAL};
      END;"

   EXEC_SQL ${sqlTxt}

   if [[ $? -ne ${OK} ]]; then
      echo "create_doc Thread: $threadVal" >> ${outputDir}/${ERRINDFILE}
      return ${FATAL}
   else
      LOG_MESSAGE "Thread ${threadVal} - Completed header validation"
      return ${OK}
   fi
}

function CHK_STATUS
{
   if [[ ! -z `ls ${MMHOME}/log/*.bad 2>/dev/null` ]]; then
      LOG_MESSAGE "Terminated with rejected records"
      return ${NON_FATAL}
   elif [[ -n `ls ${MMHOME}/log/${ERRINDFILE} 2>/dev/null` ]]; then
      LOG_MESSAGE "Terminated with aborted threads"
      return ${FATAL}
   else
      LOG_MESSAGE "Terminated Successfully"
      return ${OK}
   fi
   
}



#-------------------------------------------------------------------------
#                               MAIN
#-------------------------------------------------------------------------

# Test for the number of input arguments
if [ $# -lt 1 ]
then
   echo $USAGE
   exit 1
fi

connectStr=$1
outputDir=$MMHOME/error


USER=${connectStr%/*}

# Set filename to flag any failed executions
failed=$pgmName.$$                           # this needs to be fixed von
[ -f $failed ] && rm $failed

# If this script is killed, cleanup
trap "kill -15 0; rm -f $failed; exit 15" 1 2 3 15

LOG_MESSAGE "Started by ${USER}"

# Prepare thread lookup table
RA_BATCH_CHECK

if [[ $? -ne ${OK} ]]; then
   exit ${FATAL}
fi

# Check for rejected records, status etc
CHK_STATUS
retCode=$?

rm -f ${MMHOME}/log/${ERRINDFILE} 2>/dev/null

exit $retCode









