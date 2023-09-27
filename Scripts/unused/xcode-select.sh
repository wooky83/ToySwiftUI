#!/bin/bash
MY_WORKSPACE=$1
ENV_YAML="${MY_WORKSPACE}/env.yaml"

function normalized_build_string() {
    local VERSIONINFO="$1"
    BUILD=`echo "$VERSIONINFO" | sed -E 's/^.* ([-_0-9a-zA-Z.]+)$/\1/g'`
    echo -n $BUILD
}

function normalized_installed_build_string() {
    local VERSION_STRING="$1"
    local BUILD_REGEX="([0-9A-Za-z]+) \(([0-9A-Za-z]+)\)"

    if [[ $VERSION_STRING =~ $BUILD_REGEX ]]; then
        echo "${BASH_REMATCH[2]}"
    else
        echo ""
    fi
}

function get_xcode_path() {
    local REQUIRED_BUILD="$1"
    xcodes installed | while IFS= read -r line; do
        local BUILD=$(normalized_installed_build_string "$line")
        if [[ "$BUILD" == "$REQUIRED_BUILD" ]]; then
            echo "$line" | awk '{print $NF}'
            break
        fi
    done
}

REQUIRED_VERSIONINFO=$(ruby -ryaml -e "puts YAML.load_file(\"${ENV_YAML}\")[\"xcodebuild\"][0]")
REQUIRED_BUILD=$(normalized_build_string "$REQUIRED_VERSIONINFO")

XCODE_INSTALLED_PATH=$(get_xcode_path "$REQUIRED_BUILD")
if [[ -n "$XCODE_INSTALLED_PATH" ]]; then
    echo $XCODE_INSTALLED_PATH
fi
