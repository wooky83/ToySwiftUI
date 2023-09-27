#!/bin/bash

readonly notice_color=$'\033[0;32m' # green
readonly no_color=$'\033[0m'

NEED_TOOL_LIST=("swiftformat" "swiftlint" "swiftgen" "xcbeautify" "xcodes")
SCRIPT_DIR=$(dirname "$0")

function check_brew() {
  echo "Check installed of brew..."
  if [ ! -x "$(command -v brew)" ]; then
    echo "Install brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew update

  echo "Check installed of need tools..."
  for needTool in ${NEED_TOOL_LIST[@]}; do
    if [ ! -x "$(command -v ${needTool})" ]; then
      brew install ${needTool}
    else
      brew upgrade ${needTool}
    fi
  done
}

# Check tool ( from mint - Support Apple Silicon )
function check_required_tools() {
  if [ ! -x "$(command -v xcpretty)" ]; then
    gem install xcpretty
  fi

  if [ ! -x "$(command -v tuist)" ]; then
    sh $SCRIPT_DIR/download_tuist.sh
  fi
}

echo "${notice_color}[Check and download tools.]${no_color}"
check_brew
check_required_tools
echo "Need tool installed done"