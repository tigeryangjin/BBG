#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   slsfcilwsnplp.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

############################################################################# 
# This is an aggregate program for Retail Analytics which triggers          #
# the ODI package PLP_RETAILSALESFCSNAGGREGATE                              #
#############################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env

TBL_NAME="WK_TMP"
SCEN_NAME="PLP_RETAILSALESFCSNAGGREGATE"

echo "LOADING TABLE=WK_TMP" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME}

TBL_NAME="W_RTL_SLSFC_IT_LC_WK_SN_A"
SCEN_NAME="PLP_RETAILSALESFCSNAGGREGATE"

echo "LOADING TABLE=W_RTL_SLSFC_IT_LC_WK_SN_A" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT RA_BI.RA_TABLENAME=${TBL_NAME}


#######################################################################
#                         End of Script                               #
####################################################################### 
