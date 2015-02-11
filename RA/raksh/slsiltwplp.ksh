#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   slsiltwplp.ksh $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

###################################################################### 
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package PLP_RETAILSALESCORPORATEORGAGGREGATE              #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env

TBL_NAME="W_RTL_SLS_IT_WK_A"
SCEN_NAME="PLP_RETAILSALESCORPORATEORGAGGREGATE"


echo "LOADING TABLE=W_RTL_SLS_IT_WK_A" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME}


#######################################################################
#                         End of Script                               #
#######################################################################