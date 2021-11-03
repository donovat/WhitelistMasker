#!/bin/bash

# @author Tim Donovan IBM Research
#
set -x

echo "Unit test docker image, before deployment to cloud repo."

_version=${VERSION:-"1.0.0"}
_image_name=${IMAGE_NAME:-"maskerwebservices"}
_imageTag=${IMAGE_TAG:-"latest"}

echo "Branch: $TRAVIS_BRANCH"
echo "Image Name: $_image_name"
echo "Image Tag: $_imageTag"

docker run -p 9080:9080 --detach --name masker-test $_image_name:$_imageTag
if [ $? -ne 0 ]; then
    echo "Failed to run image."
    exit 1
fi
docker ps --format "{{.Names}} {{.Status}}"
# need to sleep to allow docker image & app to come fully available otherwise get curl ssl error.
sleep 4
result=$(curl -v -s -S --insecure http://localhost:9080/MaskWebServices/v1/HelloMasker ) ; echo $result
result=$( echo $result | cut -c 14-39 -)
docker stop masker-test
if [ $? -ne 0 ]; then
    echo "Failed to stop docker image."
fi
if [[ $result != "Hello from MaskWebServices" ]]; then 
    echo "Incorrect unit test response - Unit test failed."
    echo "Failed" >unit_test_results
    exit 1
else 
    echo "Docker Image passed Unit Test."
    echo "Passed" >unit_test_results
fi

############################################################################
# end script                                                               #
############################################################################