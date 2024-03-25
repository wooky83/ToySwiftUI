#!/bin/bash

#sync provisioning
echo "sync provisioning"

PROVISIONING_PROFILE_DIR="${HOME}/Library/MobileDevice/Provisioning Profiles/"
echo ${PROVISIONING_PROFILE_DIR}

if [ ! -d "${PROVISIONING_PROFILE_DIR}" ]; then
    mkdir -p "${PROVISIONING_PROFILE_DIR}"
fi

git clone --depth=1 git@github.com:wooky83/ToySwiftUI.git ./temp-prov
ditto ./temp-prov Externals/ios-mobileprovision
mv ./temp-prov/*.mobileprovision "${PROVISIONING_PROFILE_DIR}"
rm -rf ./temp-prov
