#!/bin/bash

readonly SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "${SCRIPT_ROOT}/.." && pwd)"

pushd $PROJECT_ROOT

export PATH=$PROJECT_ROOT/bin:$PATH

function upload_dsym {
    export SENTRY_ORG=wooky83
    export SENTRY_PROJECT=apple-ios
    export SENTRY_AUTH_TOKEN=sentry-auth-token
    ERROR=$(sentry-cli debug-files upload --include-sources "$DWARF_DSYM_FOLDER_PATH" 2>&1 >/dev/null)
    if [ ! $? -eq 0 ]; then
        echo "warning: sentry-cli - $ERROR"
    fi
}

if which sentry-cli >/dev/null; then
    upload_dsym
else
    echo "warning: sentry-cli not installed, download from https://github.com/getsentry/sentry-cli/releases"
    curl -sL https://github.com/getsentry/sentry-cli/releases/download/2.26.0/sentry-cli-Darwin-arm64 -o bin/sentry-cli
    chmod +x bin/sentry-cli
    upload_dsym
fi

popd