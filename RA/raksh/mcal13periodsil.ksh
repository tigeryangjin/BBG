#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   mcal13periodsil.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
#     This is a Source Independent Load(SIL)program for           #
#     Retail Analytics which triggers the ODI package             #
#     SIL_RETAILTIMEDIMENSION_MCAL13PERIOD                        #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env

SCEN_NAME="SIL_RETAILTIMEDIMENSION_MCAL13PERIOD"

echo "LOADING TABLE =W_MCAL_PERIOD_D"
startscen.sh $SCEN_NAME $VERSION $CONTEXT GLOBAL.GET_ODI_HOME=$ODI_HOME

####################################################################
#                       End of Script                              #
####################################################################
