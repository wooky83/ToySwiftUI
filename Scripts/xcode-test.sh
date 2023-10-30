#!/bin/bash
SCRIPT_HOME="`dirname $0`"
PROJECT_ROOT="$SCRIPT_HOME/.."
RED='\033[0;31m'
NC='\033[0m'

function normalized_build_string() {
    local VERSIONINFO="$1"
    BUILD=`echo "$VERSIONINFO" | sed -E 's/^.* ([-_0-9a-zA-Z.]+)$/\1/g'`
    echo -n $BUILD
}

function normalized_version_string() {
    local VERSIONINFO="$1"
    VERSION=`echo "$VERSIONINFO" | sed -E 's/^Xcode ([0-9a-zA-Z." "]+).*$/\1/g'`
    case "$VERSION" in
        *.*) VERSION_FORMATTED="$VERSION";;
        *) VERSION_FORMATTED="${VERSION}.0" ;;
    esac
    echo -n $VERSION_FORMATTED
}

function ensure_valid_xcode_path() {
  # Our build system hits bug when Xcode path contains non-escaping characters
  XCODE_PATH=`/usr/bin/xcrun xcode-select -p`
  if [[ "$XCODE_PATH" =~ " " ]]; then
    echo -e "${RED}Xcode Path ${XCODE_PATH} named with space is not allowed.${NC}"
    echo -e "${RED}Please rename Xcode like 'Xcode-${REQUIRED_VERSION}.app'${NC}"
    exit 1
  fi
}

function get_compatible_xcode_versions() {
    local config_file="$PROJECT_ROOT/Tuist/Config.swift"
    local version_line=$(grep "compatibleXcodeVersions" "$config_file")
    local version=$(echo "$version_line" | grep -o '".*"' | tr -d '"')
    echo "$version"
}

REQUIRED_VERSIONINFO=$(get_compatible_xcode_versions)
CURRENT_VERSIONINFO=`echo "${XCODE_VERSION_OUTPUT:-$(/usr/bin/xcrun xcodebuild -version)}" | awk -F\n -v ORS=' - '  '{print }' | sed -e 's/ - *$//g'`
SELECTED_VERSION=$(normalized_version_string "$CURRENT_VERSIONINFO")
REQUIRED_VERSION=$(normalized_version_string "$REQUIRED_VERSIONINFO")
SELECTED_BUILD=$(normalized_build_string "$CURRENT_VERSIONINFO")
REQUIRED_BUILD=$(normalized_build_string "$REQUIRED_VERSIONINFO")

SELECTED_XCODES_VERSION=`xcodes installed | grep Selected | awk -F\( '{print $1}' | tr '[a-z]' '[A-Z]'`
REQUIRED_XCODES_VERSION=`echo $REQUIRED_VERSIONINFO | sed -E 's/^Xcode ([0-9a-zA-Z." "]+).*$/\1/g' | tr '[a-z]' '[A-Z]'`

if [ "$SELECTED_XCODES_VERSION" = "$REQUIRED_XCODES_VERSION" ]; then
    ensure_valid_xcode_path
    exit 0
fi

echo "The selected version of Xcode does not match the project configuration:"
echo "  - Selected: ${SELECTED_XCODES_VERSION}"
echo "  - Required: ${REQUIRED_XCODES_VERSION}"

xcodes select ${REQUIRED_XCODES_VERSION}

if [ $? != 0 ]; then
    echo "======================="
    echo "  XCODE VERSION ERROR"
    echo "======================="
    echo "1. Please install Xcode ${REQUIRED_VERSION} from https://developer.apple.com/download"
    echo "2. Execute 'xcodes select ${REQUIRED_VERSION}' to switch Xcode"
    echo "Pass the --skip-xcode-test option if you're sure you want to use a different version."
    exit 1
fi

ensure_valid_xcode_path
