#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   mcalcfgsil.ksh  $
# $Revision: /rgbura_13.2.3_branch/1 $
# $Modtime:    $
###################################################################

###################################################################
#     This is a Source Independent Load(SIL)program for           #
#     Retail Analytics which triggers the ODI package             # 
#     SIL_TIMEDIMENSION_CALCONFIG                                 #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env

SCEN_NAME="SIL_TIMEDIMENSION_CALCONFIG"

echo "LOADING TABLE =W_MCAL_CONFIG_G" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT GLOBAL.GET_ODI_HOME=$ODI_HOME

####################################################################
#                       End of Script                              #
####################################################################  
