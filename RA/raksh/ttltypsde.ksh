#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   ttltypsde.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
# This is a source dependant extract (SDE) program for Retail     #
# Analytics which triggers the ODI package                        #
# SDE_RETAILTRANSACTIONTYPEDIMENSION                              #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env


SCEN_NAME="SDE_RETAILTRANSACTIONTYPEDIMENSION"

echo "LOADING TABLE =W_XACT_TYPE_DS"
startscen.sh $SCEN_NAME $VERSION $CONTEXT GLOBAL.GET_ODI_HOME=$ODI_HOME

####################################################################
#                       End of Script                              #
####################################################################
