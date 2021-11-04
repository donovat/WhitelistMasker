#!/bin/bash

# @author Tim Donovan IBM Research
#
# set script to fail if any command does not return '0'

# Note: This is my version of a script to install the IBM Cloud CLI tools
# rather than the DEPRICATED installer: https://ibm.biz/idt-installer 
set -ex 

whoami

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates -y
sudo update-ca-certificates 

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
############################################################################
echo "Install IBM Cloud CLI"
curl --version
curl --insecure -fsSL https://clis.cloud.ibm.com/install/linux | sh

ibmcloud --help
curl -ksSL https://clis.cloud.ibm.com/install/linux | bash
echo "Try a gain"
curl -ksSL -o install.sh https://clis.cloud.ibm.com/install/linux
cat ./install.sh
ibmcloud --help
