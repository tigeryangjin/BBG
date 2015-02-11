#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   slsdldplp.ksh $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

######################################################################
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package PLP_RETAILSALESCLDPLOCDYWKAGGREGATE               #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env

TBL_NAME="W_RTL_SLS_DP_LC_DY_A"
RA_VALUE="DP"
SCEN_NAME="PLP_RETAILSALESCLDPLOCDYWKAGGREGATE"


echo "LOADING TABLE=W_RTL_SLS_DP_LC_DY_A"
startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME} RA_BI.RA_VALUE=${RA_VALUE}


#######################################################################
#                         End of Script                               #
#######################################################################$
