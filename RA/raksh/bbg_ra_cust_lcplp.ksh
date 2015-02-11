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

TBL_NAME="BBG_RA_CUST_LC_DY_A"
SCEN_NAME="BBG_PLP_RETAIL_CUST_AGGREGATE"

echo "LOADING TABLE=BBG_RA_CUST_LC_DY_A"
startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME} 


#######################################################################
#                         End of Script                               #
#######################################################################$
