#!/usr/bin/env ksh
#
#    DESCRIPTION
#      This script is used to load ODI XML data files into ODI via ODI's startcmd.sh utility
#
#    NOTES
#      1 - Expects to have XML files placed under each of the subdirectories like below:
#
#          "FOLD" - folders
#          "TAB" - models
#          "VAR" - variables
#          "UFN" - user functions
#          "TRT" - procedures
#          "PACK" - packages
#          "POP" - interfaces
#          "SCEN" - scenarios
#
#      2 - Expects ODI_HOME and LOGDIR to be set properly in this script per customer environment:
#          ODI_HOME = where ${ODI_HOME}/bin/startcmd.sh can be found
#          LOGDIR = where marker files (err.<file>, done.<file>) are written for record-keeping
#

ODI_HOME=@ODI_HOME@
export ODI_HOME
LOGDIR=@LOGDIR@
export LOGDIR

### Do not modify script below ###
### This script is not used for any  KM import ###

cd `dirname $0`
SCRIPT_DIR=`pwd`

if [ "x${ODI_HOME}" = "x" -o "${ODI_HOME}" = "@ODI_HOME@" -o "x${LOGDIR}" = "x" -o "${LOGDIR}" = "@LOGDIR@" ]; then
    echo "$0 ERROR: You must set and export ODI_HOME, LOGDIR environment variables in this script."
    exit 1
fi

if [ ! -r ${ODI_HOME}/bin/startcmd.sh ]; then
    echo "$0 ERROR: You do not have read permission to ${ODI_HOME}/bin/startcmd.sh or that the file does not exist!"
    exit 1
fi

mkdir -p "${LOGDIR}"

if [ $? -ne 0 ]; then
    echo "$0 ERROR: Failed to create the log directory: ${LOGDIR}"
    echo "    Please change the value of LOGDIR in the script or resolve the permission issue and re-try."
    exit 1
fi

status=0

rm -f ${LOGDIR}/err.*

ODI_TYPE="FOLD TAB VAR UFN TRT PACK POP SCEN"
export ODI_TYPE

echo "Using ODI_HOME=${ODI_HOME}"
echo "Using LOGDIR=${LOGDIR}"

for field in ${ODI_TYPE}; do
   echo
   echo "=== Importing ${field} file(s), if any ..."
   find "${SCRIPT_DIR}/${field}" -name "${field}_*" -type f | while read file
   do
      src_basename=`basename ${file}`
      if [ ! -f "${LOGDIR}/done.${src_basename}" ]
      then
         if [ "${field}" = "SCEN" ]; then
            sh "${ODI_HOME}"/bin/startcmd.sh OdiImportScen "-file_name=${file}" -import_mode=SYNONYM_Insert_Update
         else
            sh "${ODI_HOME}"/bin/startcmd.sh OdiImportObject "-file_name=${file}" -import_mode=SYNONYM_Insert_Update
         fi
 
         status=$?

         if [ $status -ne 0 ]; then 
            touch "${LOGDIR}/err.${src_basename}"
            echo "----------------------------------------------------------------"
            echo "$0 ERROR: There was a problem during the ODI import of ${file}."
            echo "    You may fix the root cause and re-run this script. The import"
            echo "    process will resume with this file. Files which have loaded "
            echo "    successfully will not be re-loaded into ODI."
            echo "----------------------------------------------------------------"
            exit $status
         else
            touch "${LOGDIR}/done.${src_basename}"
         fi
      else
         echo "WARNING: Skipping ${file} due to the presence of ${LOGDIR}/done.${src_basename}, indicating that it is already loaded."
      fi
   done
done

echo
echo "All files (if any) were imported without errors!"
