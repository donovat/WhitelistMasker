#!/bin/bash

# @author Tim Donovan IBM Research
#
# set script to fail if any command does not return '0'
set -e 

echo "Script to push an image built within Travis-ci to IBM's Cloud image repo."
echo "This script is called by Travis-ci during the deploy stage."

echo "IBM Cloud Region: $IBM_CLOUD_REGION"
echo "Container Registry Region: $REGISTRY_REGION"
echo "Container Registry Namespace: $REGISTRY_NAMESPACE"
echo 
echo "Image name: $IMAGE_NAME"
echo "Image tag: $IMAGE_TAG"

############################################################################
# Log into the IBM Cloud container registry                                          #
############################################################################
echo "Checking connected to IBM's Cloud container registry"
ibmcloud cr login
if [ $? -ne 0 ]; then
  echo "Failed to authenticate to IBM Cloud container registry"
  exit 1
fi
ibmcloud cr images

############################################################################
# Ask Docker to tag the image as latest and with the custom tag            #
############################################################################
echo "Tagging the image as $REGISTRY_REGION/$REGISTRY_NAMESPACE/$IMAGE_NAME:$IMAGE_TAG and $REGISTRY_REGION/$REGISTRY_NAMESPACE/$IMAGE_NAME:latest"
docker tag $IMAGE_NAME:$IMAGE_TAG $REGISTRY_REGION/$REGISTRY_NAMESPACE/$IMAGE_NAME:$IMAGE_TAG
docker tag $IMAGE_NAME:$IMAGE_TAG $REGISTRY_REGION/$REGISTRY_NAMESPACE/$IMAG
E_NAME:latest

############################################################################
# Push the image                                                           #
############################################################################
echo "Pushing image to registry"
docker push $REGISTRY_REGION/$REGISTRY_NAMESPACE/$IMAGE_NAME:$IMAGE_TAG
docker push $REGISTRY_REGION/$REGISTRY_NAMESPACE/$IMAGE_NAME:latest
############################################################################
# end script                                                               #
############################################################################

