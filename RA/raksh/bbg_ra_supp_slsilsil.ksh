#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   slsilsil.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
#     This is a Source Independent Load(SIL)program for           #
#     Retail Analytics which triggers the ODI package             # 
#     MASTER_SIL_RETAIL_SALESTRANSACTIONFACT                      #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env


SCEN_NAME="MASTER_BBG_SIL_BBG_RA_SUPP_SALES_IT_LC_DY_F"

echo "LOADING TABLE =BBG_RA_SUPP_SALES_IT_LC_DY_F"
startscen.sh $SCEN_NAME $VERSION $CONTEXT
####################################################################
#                       End of Script                              #
####################################################################  
