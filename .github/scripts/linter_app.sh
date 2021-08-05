#!/bin/bash

set -eo pipefail

if which swiftlint >/dev/null; then
  swiftlint --config $PWD/.swiftlint.yml
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi