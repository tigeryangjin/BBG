#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   invildsil.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
#     This is a Source Independent Load(SIL)program for           #
#     Retail Analytics which triggers the ODI package             # 
#     MASTER_SIL_RETAILINVPOSITIONFACT                            #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env

SCEN_NAME="MASTER_SIL_RETAILINVPOSITIONFACT"

echo "LOADING TABLE =W_RTL_INV_IT_LC_G" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT

####################################################################
#                       End of Script                              #
####################################################################  