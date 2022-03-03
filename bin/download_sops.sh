#!/usr/bin/env bash

# Set the variables
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TMP_DIR=$SCRIPT_DIR/tmp
REPO=mozilla/sops
BIN_FILE=sops

# Get latest release and download linux zip file
curl -s https://api.github.com/repos/$REPO/releases/latest \
| grep "browser_download_url.*linux" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -O $SCRIPT_DIR/$BIN_FILE -qi -

chmod +x $SCRIPT_DIR/$BIN_FILE

# Run script the first time to extract version
$SCRIPT_DIR/$BIN_FILE -v
