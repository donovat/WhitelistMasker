#!/bin/bash

# @author Tim Donovan IBM Research
#
# set script to fail if any command does not return '0'
<<<<<<< HEAD

# Note: This is my version of a script to install the IBM Cloud CLI tools
# rather than the DEPRICATED installer: https://ibm.biz/idt-installer 
set -e 
set +x

############################################################################
# Download and install the IBM Cloud CLI tool.                             #
# Documentation on details can be found here:                              #
#    https://cloud.ibm.com/docs/cli/index.html                             #
# note: curl flags -s=quite -S=show errers -L=follow redirects             #
############################################################################
echo "Install IBM Cloud CLI"
curl -sSL https://clis.cloud.ibm.com/install/linux | sh

ibmcloud version
ibmcloud plugin list
=======
############################################################################
echo "Install IBM Cloud CLI"
curl --version
curl --insecure -fsSL https://clis.cloud.ibm.com/install/linux | sh

ibmcloud --help
