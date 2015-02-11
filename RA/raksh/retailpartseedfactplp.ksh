#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   retailpartseedfactplp.ksh  $
# $Revision: /rgbura_13.2.3_branch/1 $
# $Modtime:    $
###################################################################

############################################################################# 
# This is an aggregate program for Retail Analytics which triggers          #
# the ODI package MASTER_PLP_RETAILPARTSEEDFACT                             #
#############################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env

#TBL_NAME=$1
#TBL_NAME="W_RTL_INV_IT_LC_DY_F"
#SCEN_NAME="MASTER_PLP_RETAILPARTSEEDFACT"

#if [[ $TBL_NAME = "" ]];
#then
 # echo "USAGE: $0 TARGET_TABLE_NAME"
 # exit -1
#else
#  startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME}
#fi

####################################################################
#                       End of Script                              #
####################################################################

#TBL_NAME="W_RTL_BCOST_IT_LC_DY_F"
#SCEN_NAME="MASTER_PLP_RETAILPARTSEEDFACT"

 #startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME}

#TBL_NAME="W_RTL_NCOST_IT_LC_DY_F"
#SCEN_NAME="MASTER_PLP_RETAILPARTSEEDFACT"
 
# startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME}

#TBL_NAME="W_RTL_PRICE_IT_LC_DY_F"
#SCEN_NAME="MASTER_PLP_RETAILPARTSEEDFACT"

 #startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME}

#TBL_NAME="BBG_RA_SUPP_INV_IT_LC_DY_F"
#SCEN_NAME="MASTER_PLP_RETAILPARTSEEDFACT"

 #startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME}

