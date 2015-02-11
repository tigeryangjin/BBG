#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   orgdimreclassplp.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

######################################################################
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package PLP_RETAILORGANIZATIONDIMENSIONRECLASSTEMP        #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env



SCEN_NAME="PLP_RETAILORGANIZATIONDIMENSIONRECLASSTEMP"


echo "LOADING TABLE =W_RTL_ORG_RECLASS_TMP"
startscen.sh $SCEN_NAME $VERSION $CONTEXT 



#######################################################################
#                         End of Script                               #
#######################################################################$

