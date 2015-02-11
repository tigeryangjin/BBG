#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   stlblmthgregsil.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
#     This is a Source Independent Load(SIL)program for           #
#     Retail Analytics which triggers the ODI package             #
#     MASTER_SIL_RETAILSTOCKLEDGERMONTHFACT (gregorian calendar)  #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env

SCEN_NAME="MASTER_SIL_RETAILSTOCKLEDGERMONTHFACT"
CALENDAR_NAME="GREGORIAN"

echo "LOADING TABLE =W_RTL_STCKLDGR_SC_LC_MH_F"
startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_STCK_LDGR_CALENDAR_NAME=$CALENDAR_NAME

####################################################################
#                       End of Script                              #
####################################################################
