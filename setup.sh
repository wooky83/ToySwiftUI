#!/bin/sh -e
set -o pipefail

sh Scripts/download_tools.sh

defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines YES

echo "==========================="
echo " Setup Complete."
echo "==========================="
echo "You should run \`./update.sh\`"
echo "==========================="
