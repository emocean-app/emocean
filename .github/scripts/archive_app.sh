
#!/bin/bash

set -eo pipefail

xcodebuild -project emocean.xcodeproj \
            -scheme emocean \
            -sdk iphoneos \
            -configuration release \
            -archivePath $PWD/build/emocean.xcarchive \
            clean archive | xcpretty
