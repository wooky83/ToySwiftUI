#!/bin/bash

readonly notice_color=$'\033[0;32m' # green
readonly no_color=$'\033[0m'

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PRE_COMMIT_SCRIPT_PATH=${SOURCE_DIR}/pre_commit
PRE_COMMIT_PATH=${SOURCE_DIR}/../.git/hooks/pre-commit

echo "${notice_color}[Copying git hooks.]${no_color}"
cp ${PRE_COMMIT_SCRIPT_PATH} ${PRE_COMMIT_PATH}

chmod +x ${PRE_COMMIT_PATH}
