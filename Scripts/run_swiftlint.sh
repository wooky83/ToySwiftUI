#!/bin/bash

if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi
export PATH

SCRIPT_DIR=$(dirname "$0")

if which swiftlint >/dev/null; then
    if [ $(find . -name "*.swift" | wc -l) -gt 0 ]; then
        swiftlint --config $SCRIPT_DIR/../.swiftlint.yml "$1/Sources"
    fi
else
    echo "warning: SwiftLint not installed, Please run to 'setup.sh'"
fi
