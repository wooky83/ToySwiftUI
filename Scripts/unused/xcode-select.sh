#!/bin/bash
LINEIOS_WORKSPACE=$1
ENV_YAML="${LINEIOS_WORKSPACE}/env.yaml"
XCODES="xcodes"

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
    local REQUIRED_XCODE_VERSION="$1"
    ${XCODES} installed | while IFS= read -r line; do
        local BUILD=$(normalized_installed_build_string "$line")
        if [[ "$BUILD" == "$REQUIRED_XCODE_VERSION" ]]; then
            echo "$line" | awk '{print $NF}'
            break
        fi
    done
}

REQUIRED_VERSIONINFO=$(ruby -ryaml -e "puts YAML.load_file(\"${ENV_YAML}\")[\"xcodebuild\"][0]")
REQUIRED_BUILD=$(normalized_build_string "${REQUIRED_VERSIONINFO}")

SELECTED_XCODES_VERSION=`${XCODES} installed | grep Selected | awk -F\( '{print $1}' | tr '[a-z]' '[A-Z]'`
REQUIRED_XCODES_VERSION=`echo $REQUIRED_VERSIONINFO | sed -E 's/^Xcode ([0-9a-zA-Z." "]+).*$/\1/g' | tr '[a-z]' '[A-Z]'`

if [ "$SELECTED_XCODES_VERSION" != "$REQUIRED_XCODES_VERSION" ]; then
    echo ${ADMIN_PASSWORD} | sudo -S ${XCODES} select ${REQUIRED_XCODES_VERSION} >/dev/null 2>&1
fi

XCODE_INSTALLED_PATH=$(get_xcode_path "$REQUIRED_BUILD")
if [[ -n "${XCODE_INSTALLED_PATH}" ]]; then
    echo ${XCODE_INSTALLED_PATH}
else
    echo "❌ Failed to retrieve the Xcode path for version ${REQUIRED_XCODES_VERSION}" 1>&2
fi
