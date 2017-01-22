#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   bbg_invadjsccldplcdyplp.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

######################################################################
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package   PLP_RETAILINVADJSCCLDPLCDYAGGREGATE             #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env


SCEN_NAME="PLP_RETAILINVADJSCCLDPLCDYAGGREGATE"

echo "LOADING TABLE=BBG_RA_INVADJ_SC_LC_DY_TMP"
echo "LOADING TABLE=BBG_RA_INVADJ_SC_LC_DY_A"
echo "LOADING TABLE=BBG_RA_INVADJ_CL_LC_DY_A"
echo "LOADING TABLE=BBG_RA_INVADJ_DP_LC_DY_A"
startscen.sh $SCEN_NAME $VERSION $CONTEXT 


#######################################################################
#                         End of Script                               #
#######################################################################
