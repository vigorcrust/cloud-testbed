#!/usr/bin/env bash

# Set the variables
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TMP_DIR=$SCRIPT_DIR/tmp
REPO=kubermatic/kubeone
BIN_FILE=kubeone

# Cleanup old remains
rm -rf $TMP_DIR
mkdir $TMP_DIR

# Get latest release and download linux zip file
curl -s https://api.github.com/repos/$REPO/releases/latest \
| grep "browser_download_url.*linux_amd64.zip" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -O $TMP_DIR/$BIN_FILE.zip -qi -

# unpack the zip into tmp
unzip -qq $TMP_DIR/$BIN_FILE.zip -d $TMP_DIR

# extract the needed files and modify them as needed
mv $TMP_DIR/$BIN_FILE $SCRIPT_DIR/$BIN_FILE
chmod +x $SCRIPT_DIR/$BIN_FILE

# Change to Changelog
#mv $TMP_DIR/README.md $SCRIPT_DIR/$BIN_FILE_README.md

# Cleanup remains
rm -rf $TMP_DIR

# Run script the first time to extract version
$SCRIPT_DIR/$BIN_FILE version
