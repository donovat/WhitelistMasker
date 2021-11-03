#!/bin/bash

# @author Tim Donovan IBM Research
#
# set script to fail if any command does not return '0'
set -e 
set +x

ls -al /etc/ssl/certs/ca-certificates.crt 
ls -al /etc/ssl/certs/

############################################################################
# Download and install the IBM Cloud CLI tool.                             #
# Documentation on details can be found here:                              #
#    https://cloud.ibm.com/docs/cli/index.html                             #
############################################################################
echo "Install IBM Cloud CLI"
curl --insecure -fsSL https://clis.cloud.ibm.com/install/linux | sh

ibmcloud --help