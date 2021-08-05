
#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/emocean.xcarchive \
            -exportOptionsPlist emocean/exportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty
