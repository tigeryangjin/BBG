#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   prdhierlkupsil.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
#     This is a Source Independent Load(SIL)program for           #
#     Retail Analytics which triggers the ODI package             # 
#     SIL_RETAILPRODUCTHIERARCHYLKPDIMENSION                      #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env

SCEN_NAME="SIL_RETAILPRODUCTHIERARCHYLKPDIMENSION"

echo "LOADING TABLE =W_RTL_PROD_HIER_ATTR_LKP_DH" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT

####################################################################
#                       End of Script                              #
####################################################################  