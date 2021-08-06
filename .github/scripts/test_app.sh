
#!/bin/bash

set -eo pipefail

xcodebuild -project emocean.xcodeproj \
            -scheme emocean \
            -destination platform=iOS\ Simulator,OS=14.4,name=iPhone\ 12 \
            clean test | xcpretty
