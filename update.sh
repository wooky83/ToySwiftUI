#!/bin/bash -e

readonly notice_color=$'\033[0;32m' # green
readonly no_color=$'\033[0m'

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
CI_MODE=false

while getopts am:h OPT; do
  case $OPT in
  a)
    CI_MODE=true
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

if ${CI_MODE}; then
  sh setup.sh
else 
  sh Scripts/copy_githooks.sh
fi

echo "${notice_color}[Generating projects]${no_color}"
tuist fetch
tuist generate --no-open

if ! ${CI_MODE}; then
    echo "${notice_color}[Open project]${no_color}"
    open ToySwiftUI.xcworkspace
fi
