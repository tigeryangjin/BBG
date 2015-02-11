#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   orglocwkplp.ksh  $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

######################################################################
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package PLP_RETAILLOCATIONWEEKDIMENSION                   #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env



SCEN_NAME="PLP_RETAILLOCATIONWEEKDIMENSION"


echo "LOADING TABLE =W_RTL_LOC_WK_D"
startscen.sh $SCEN_NAME $VERSION $CONTEXT 



#######################################################################
#                         End of Script                               #
#######################################################################$
