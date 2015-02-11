#!/bin/ksh

##################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   orghiersde.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
###################################################################

###################################################################
# This is a source dependant extract (SDE) program for Retail     #
# Analytics which triggers the ODI package                        #
# SDE_RETAILORGANIZATIONDIMENSIONHIERARCHY                        #
###################################################################


################BOF This is part of the ra_profile#################

. $MMHOME/etc/ra.env


SCEN_NAME="SDE_RETAILORGANIZATIONDIMENSIONHIERARCHY"

echo "LOADING TABLE =W_INT_ORG_DHS" 
startscen.sh $SCEN_NAME $VERSION $CONTEXT 

####################################################################
#                       End of Script                              #
####################################################################