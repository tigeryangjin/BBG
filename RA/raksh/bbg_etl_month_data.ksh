#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   mcalqtrsil.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
#     This is a Source Independent Load(SIL)program for           #
#     Retail Analytics which triggers the ODI package             # 
#     SIL_TIMEDIMENSION_MCALQUARTER                               #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env

SCEN_NAME="BBG_ETL_MONTH_DATA"

echo "LOADING ALL MONTH_TABLE DATA" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT

####################################################################
#                       End of Script                              #
####################################################################  
