#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   bbg_ra_fund_sde.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

######################################################################
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package   MASTER_SDE_BBG_RA_FUND_IT_LC_SUPP_DY_FS                   #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env


SCEN_NAME="MASTER_SDE_BBG_RA_FUND_IT_LC_SUPP_DY_FS"

echo "LOADING TABLE=BBG_RA_FUND_IT_LC_SUPP_DY_FS"
startscen.sh $SCEN_NAME $VERSION $CONTEXT 


#######################################################################
#                         End of Script                               #
#######################################################################
