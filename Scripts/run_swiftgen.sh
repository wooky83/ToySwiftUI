#!/bin/bash

if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi
export PATH

SCRIPT_DIR=$(dirname "$0")
pushd $SCRIPT_DIR

if which swiftgen >/dev/null; then
    swiftgen config run --config swiftgen/swiftgen.yml
else
    echo "warning: SwiftGen not installed, Please run to 'update.sh'"
fi

popd
