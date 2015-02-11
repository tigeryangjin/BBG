#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   factopenplp.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
# This is an aggregate program for Retail Analytics which triggers#
# the ODI package MASTER_PLP_RETAILFACTOPENFACT                   #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env


SCEN_NAME="MASTER_PLP_RETAILFACTOPENFACT"

echo "LOADING POSITION FACT TABLES" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT 


####################################################################
#                       End of Script                              #
####################################################################