#!/bin/bash -e

IPHONE_NAME="iPhone 12"
WATCH_NAME="Apple Watch Series 7 (41mm)"

function get_simulator_udid() {
    local DEVICE_NAME=$1
    echo $(xcrun simctl list devices "iOS ${IOS_SDK_VERSION}" available | grep "${DEVICE_NAME}" | sed 1q | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | rev | cut -d ')' -f3 | rev | cut -d '(' -f2)
}

function get_watch_udid() {
    local AVAILABLE_IPHONE_NAME=$1
    local IPHONE_SIMULATOR_UDID=$2
    local REGEX_WATCH_NAME=$(echo ${WATCH_NAME} | sed 's/(/\\(/g' | sed 's/)/\\)/g')
    echo $(xcrun xctrace list devices | grep -A 1 "${IPHONE_SIMULATOR_UDID}" | tail -n 1 | grep -E "${AVAILABLE_IPHONE_NAME}.*${REGEX_WATCH_NAME}" | tail -1 | awk -F' ' '{print $NF}' | tr -d "()")
}

function verify_simulator_runtimes() {
    for OS in iOS watchOS; do
        local SDK_VERSION_VAR="$(echo ${OS} | tr '[:lower:]' '[:upper:]')_SDK_VERSION"
        local SDK_VERSION=${!SDK_VERSION_VAR}
        if [[ -z "$(xcrun simctl list runtimes | grep \.${OS}-${SDK_VERSION} | tail -1 | cut -d ' ' -f 2)" ]]; then
            echo "❌ Failed to get the ${SDK_VERSION} SDK version of ${OS}"
            exit 1
        fi
    done
}

function create_simulator() {
    local DEVICE_NAME=$1
    local DEVICE_TYPE=$2
    local DEVICE_OS=$3
    local UDID=$(xcrun simctl create "${DEVICE_NAME}" "${DEVICE_TYPE}" "${DEVICE_OS}")
    if [[ $? != 0 ]]; then
        echo "❌ ${DEVICE_NAME} wasn't created!!!"
        exit 1
    fi
    echo $UDID
}

function get_os_version() {
    local SDK_VERSION=$1
    echo $(xcrun simctl list runtimes | grep "${SDK_VERSION}" | awk -F '[()]' '{print $2}' | awk -F' - ' '{print $1}' | sort -V | tail -1)
}

function create_simulator_pair() {
    local SUFFIX=$1
    verify_simulator_runtimes

    local IPHONE_ALIAS_NAME=${IPHONE_NAME}
    local WATCH_ALIAS_NAME=${WATCH_NAME}
    IPHONE_ALIAS_NAME="${IPHONE_NAME}${SUFFIX}"
    WATCH_ALIAS_NAME="${WATCH_NAME}${SUFFIX}"
    
    IPHONE_SIMULATOR_UDID=$(create_simulator "${IPHONE_ALIAS_NAME}" "${IPHONE_NAME}" "iOS$(get_os_version ${IOS_SDK_VERSION})")
    WATCH_SIMULATOR_UDID=$(create_simulator "${WATCH_ALIAS_NAME}" "${WATCH_NAME}" "watchOS$(get_os_version ${WATCH_SDK_VERSION})")
    xcrun simctl pair ${IPHONE_SIMULATOR_UDID} ${WATCH_SIMULATOR_UDID} >/dev/null 2>&1
    if [[ $? != 0 ]]; then
        echo "❌ simulator pair wasn't created!!!"
        exit 1
    fi
    echo "✅ ios, watchos simulator created complete"
    AVAILABLE_IPHONE="${IPHONE_ALIAS_NAME}"
}

function verify_iphone_simulator() {
    local INDEX_DELIMITER=$1
    local IPHONE_SIMULATOR_INDEX=$(echo "${WORKSPACE}" | awk -F'@' '{print $2}')
    if [[ -n "${IPHONE_SIMULATOR_INDEX}" ]]; then
        IPHONE_SIMULATOR_INDEX="${INDEX_DELIMITER:-"#"}${IPHONE_SIMULATOR_INDEX}"
    else
        IPHONE_SIMULATOR_INDEX="${INDEX_DELIMITER:-""}"
    fi

    IOS_SDK_VERSION=$(xcrun xcodebuild -showsdks | grep iphonesimulator | grep -o 'iOS [0-9.]*' | awk '{print $2}')
    WATCH_SDK_VERSION=$(xcrun xcodebuild -showsdks | grep watchsimulator | grep -o 'watchOS [0-9.]*' | awk '{print $2}')

    local SELECTED_IPHONE=""
    IFS=$'\n'
    local SPECIFIC_DEVICE_NAME="${IPHONE_NAME}${IPHONE_SIMULATOR_INDEX}"
    for NAME in $(xcrun simctl list devices "iOS ${IOS_SDK_VERSION}" available | grep "${SPECIFIC_DEVICE_NAME}" | sed 's/ (.*)//' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'); do
        if [[ "${SPECIFIC_DEVICE_NAME}" == "${NAME}" ]]; then
            AVAILABLE_IPHONE="${NAME}"
            IPHONE_SIMULATOR_UDID=$(get_simulator_udid "${AVAILABLE_IPHONE}")
            WATCH_SIMULATOR_UDID=$(get_watch_udid "${AVAILABLE_IPHONE}" "${IPHONE_SIMULATOR_UDID}")
            if [[ -n ${WATCH_SIMULATOR_UDID} ]]; then
                SELECTED_IPHONE="${NAME}"
                break
            fi
        fi
    done
    unset IFS
    if [[ -n ${SELECTED_IPHONE} ]]; then
        xcrun simctl erase "${IPHONE_SIMULATOR_UDID}" >>/dev/null 2>&1 || true
        xcrun simctl erase "${WATCH_SIMULATOR_UDID}" >>/dev/null 2>&1 || true
    elif [[ -n ${AVAILABLE_IPHONE} ]] && [[ -n ${IPHONE_SIMULATOR_UDID} ]] && [[ -z ${WATCH_SIMULATOR_UDID} ]]; then
        xcrun simctl delete "${IPHONE_SIMULATOR_UDID}"
        create_simulator_pair ${IPHONE_SIMULATOR_INDEX}
    else
        create_simulator_pair ${IPHONE_SIMULATOR_INDEX}
    fi
    export DEVICE_NAME="${AVAILABLE_IPHONE} ($(get_os_version ${IOS_SDK_VERSION}))"
    echo "✅ ${DEVICE_NAME} simulator selected complete"
}
