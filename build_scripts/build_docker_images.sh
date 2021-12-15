#!/bin/bash

# @author Tim Donovan IBM Research
#
set -ev

echo "This is the script to build one or more Docker Images"
echo "related to the WhitelistMasker"

# Check if Masker jar file has been built into target directory
if [[ ! -f Masker/target/Masker-1.1.8-jar-with-dependencies.jar ]]; then
   echo "Missing Masker jar file in Masker/target, cannot continue with build."
   exit 1
fi
# Check if MaskWebServices war file present
if [[ ! -f MaskWebServices/target/MaskWebServices-1.1.8.war ]]; then
   echo "Missing MaskWebServices war file in target, cannot continue with build."
   exit 1
fi

#_version=${VERSION:-"1.0.0"}
_ImageName=${IMAGE_NAME:-"maskerwebservices"}
_imageTag=${IMAGE_TAG:-"1.0.8"}

echo "Image Name: $_ImageName"
echo "Image Tag: $_imageTag"

echo "Note: At the moment all images are only pushed to the local docker repository."
# build docker image ( original flag --progress plain errors )
DOCKER_BUILDKIT=0 docker build --no-cache --tag $_ImageName:$_imageTag  -f MaskWebServices/Dockerfile_MaskWebServices .
if [ $? -ne 0 ]; then
   echo "Failed to build image."
   exit 1
fi

echo "Finished !!"

############################################################################
# end script                                                               #
############################################################################