#!/bin/bash

# @author Tim Donovan IBM Research
#
set -ev
set -x

echo "This is the script to build one or more Docker Images"
echo "related to the WhitelistMasker"

# Check if Masker jar file has been built into target directory
if [[ ! -f Masker/target/Masker-1.1.4-jar-with-dependencies.jar ]]; then
   echo "Missing Masker jar file in Masker/target, cannot continue with build."
   exit 1
fi
# Check if MaskWebServices war file present
if [[ ! -f MaskWebServices/target/MaskWebServices-1.1.4.war ]]; then
   echo "Missing MaskWebServices war file in target, cannot continue with build."
   exit 1
fi

#_version=${VERSION:-"1.0.0"}
_ImageName=${IMAGE_NAME:-"maskerwebservices"}
_imageTag=${IMAGE_TAG:-"1.0.0"}

echo "Image Name: ${IMAGE_NAME}"
echo "Image Tag: $_imageTag"

echo "Note: At the moment all images are only pushed to the local docker repository."
# build docker image
DOCKER_BUILDKIT=0 docker build --no-cache --progress plain --tag _ImageName:$_imageTag  -f /MaskWebServices/Dockerfile_MaskWebServices .
if [ $? -ne 0 ]; then
   echo "Failed to build image."
   exit 1
fi

echo "Finished !!"

############################################################################
# end script                                                               #
############################################################################
