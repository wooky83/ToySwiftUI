#!/bin/bash -e

readonly notice_color=$'\033[0;32m' # green
readonly no_color=$'\033[0m'

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
DEVELOPER_MODE=true

if ${DEVELOPER_MODE}; then
    sh Scripts/download_tools.sh
    sh Scripts/copy_githooks.sh
fi

echo "${notice_color}[Generating projects]${no_color}"
tuist fetch
tuist generate
