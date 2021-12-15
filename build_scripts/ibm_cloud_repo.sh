#!/bin/bash

# @author Tim Donovan IBM Research
#
# Set script to fail if any command does not return '0'
set -ex

echo "Script to login Travis-ci to IBM's Cloud image repo."

echo "IBM Cloud Region: $IBM_CLOUD_REGION"
echo "Container Registry Region: $REGISTRY_REGION"
echo "Container Registry Namespace: $REGISTRY_NAMESPACE"
echo 

############################################################################
# Download and install a few CLI tools and the Kubernetes Service plug-in. #
# Documentation on details can be found here:                              #
#    https://github.com/IBM-Cloud/ibm-cloud-developer-tools                #
############################################################################
echo "Install IBM Cloud CLI"
curl --insecure -sL https://ibm.biz/idt-installer | bash

############################################################################
# Log into the IBM Cloud environment using apikey                          #
############################################################################
echo "Login to IBM Cloud using apikey"
ibmcloud login -r ${IBM_CLOUD_REGION} --apikey ${IBM_CLOUD_API_KEY}
if [ $? -ne 0 ]; then
  echo "Failed to authenticate to IBM Cloud"
  exit 1
fi

############################################################################
# Set the right Region for IBM Cloud container registry                    #
############################################################################
echo "Switch to the correct region for the required IBM Cloud container registry"
ibmcloud cr region-set ${REGISTRY_REGION}
if [ $? -ne 0 ]; then
  echo "Failed to switch to correct IBM Cloud container registry region"
  exit 1
fi

############################################################################
# Log into the IBM Cloud container registry                                          #
############################################################################
echo "Logging into IBM Cloud container registry"
ibmcloud cr login
if [ $? -ne 0 ]; then
  echo "Failed to authenticate to IBM Cloud container registry"
  exit 1
fi
############################################################################
# Check If the waa_full_base:1.0 image exists in the container registry,   #
# which is needed to make many of the other images.                        #
############################################################################

ibmcloud cr images
#lookup_image=$(ibmcloud cr image-list --format '{{.Repository}}:{{.Tag}}' | grep "waa_full_base:latest")
#echo $lookup_image > base_image_flag
#cat base_image_flag
#lookup_image=$( ibmcloud cr images | grep "$REGISTRY_REGION/$REGISTRY_NAMESPACE/waa_full_base:1.0" )

############################################################################
# end script                                                               #
############################################################################
