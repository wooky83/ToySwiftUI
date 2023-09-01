#!/bin/bash -e

readonly notice_color=$'\033[0;32m' # green
readonly no_color=$'\033[0m'

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
DEVELOPER_MODE=false

while getopts am:h OPT; do
  case $OPT in
  a)
    DEVELOPER_MODE=true
    ;;
  m)
    echo "Message $OPTARG"    
    ;;
  h)
    echo "^^ NO HELP YET ^^"
    exit 1
    ;;
  esac
done

if ${DEVELOPER_MODE}; then
    sh Scripts/download_tools.sh
    sh Scripts/copy_githooks.sh
fi

echo "${notice_color}[Generating projects]${no_color}"
tuist fetch
tuist generate
