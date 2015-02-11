#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   slscldplp.ksh $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

######################################################################
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package PLP_RETAILSALESCLDPLOCDYWKAGGREGATE               #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env

TBL_NAME="BBG_RA_SLS_CL_LC_DY_A"
RA_VALUE="CL"
SCEN_NAME="PLP_RETAILSUPPSALESCLDPLOCDYWKAGGREGATE"


echo "LOADING TABLE=BBG_RA_SLS_CL_LC_DY_A"
startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME} RA_BI.RA_VALUE=${RA_VALUE}


#######################################################################
#                         End of Script                               #
#######################################################################$
