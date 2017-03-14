#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   bbg_ra_fund_itlcdy_sil.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

######################################################################
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package   PLP_RETAIL_FUND_ITLCDYSUPP_AGGREGATE            #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env


SCEN_NAME="PLP_RETAIL_FUND_ITLCDYSUPP_AGGREGATE"

echo "LOADING TABLE=BBG_RA_FUND_IT_LC_SUPP_DY_A"
startscen.sh $SCEN_NAME $VERSION $CONTEXT 


#######################################################################
#                         End of Script                               #
#######################################################################
