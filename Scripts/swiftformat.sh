#!/bin/sh
PRE_IFS=$IFS
IFS=$'\n'

OTHER_ARGS=( "$@" )
root=$(git rev-parse --show-toplevel)
swiftformatConfig="${root}/.swiftformat"
swiftversion="5.9.1"

swiftformat --swiftversion $swiftversion --config "$swiftformatConfig" "${OTHER_ARGS[@]}"

