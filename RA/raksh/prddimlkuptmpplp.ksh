#!/bin/ksh

#####################################################################
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved. 
# $Workfile:   prddimlkuptmpplp.ksh $
# $Revision: /main/1 $
# $Modtime:    $
######################################################################

######################################################################
#  This is an aggregate program for Retail Analytics which triggers  #
#  the ODI package PLP_RETAILPRODUCTDIMENSIONLKUPTEMP                #
######################################################################


################BOF This is part of the ra_profile####################

. $MMHOME/etc/ra.env


SCEN_NAME="PLP_RETAILPRODUCTDIMENSIONLKUPTEMP"


echo "LOADING TABLE=W_PRODUCT_D_RTL_TMP"
startscen.sh $SCEN_NAME $VERSION $CONTEXT 


#######################################################################
#                         End of Script                               #
#######################################################################$
