#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   prcilsil.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
#     This is a Source Independent Load(SIL)program for           #
#     Retail Analytics which triggers the ODI package             # 
#     MASTER_SIL_RETAILPRICEFACT                                  #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env

SCEN_NAME="MASTER_SIL_BBG_RETAILPRICEFACT"

echo "LOADING TABLE =W_RTL_PRICE_IT_LC_G" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT

####################################################################
#                       End of Script                              #
####################################################################  
