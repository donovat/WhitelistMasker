#!/bin/bash

# @author Tim Donovan IBM Research
#
# set script to fail if any command does not return '0'
set -e 
set -x

############################################################################
# Download and install the IBM Cloud CLI tool.                             #
# Documentation on details can be found here:                              #
#    https://cloud.ibm.com/docs/cli/index.html                             #
############################################################################
echo "Install IBM Cloud CLI"
curl --version
wget http://clis.cloud.ibm.com/install/linux
curl -ksSL -o install.sh https://clis.cloud.ibm.com/install/linux
cat ./install.sh
echo "Try a gain"
curl -ksSL -o install.sh https://clis.cloud.ibm.com/install/linux | sh

ibmcloud --help