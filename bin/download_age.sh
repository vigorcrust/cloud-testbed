#!/usr/bin/env bash

# Set the variables
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TMP_DIR=$SCRIPT_DIR/tmp
REPO=FiloSottile/age
BIN_FILE=age

# Cleanup old remains
rm -rf $TMP_DIR
mkdir $TMP_DIR

# Get latest release and download linux zip file
curl -s https://api.github.com/repos/$REPO/releases/latest \
| grep "browser_download_url.*linux-amd64.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -O $TMP_DIR/$BIN_FILE.tar.gz -qi -

tar -xvzf $TMP_DIR/$BIN_FILE.tar.gz -C $TMP_DIR

mv $TMP_DIR/$BIN_FILE/$BIN_FILE $SCRIPT_DIR
mv $TMP_DIR/$BIN_FILE/$BIN_FILE-keygen $SCRIPT_DIR

chmod +x $SCRIPT_DIR/$BIN_FILE
chmod +x $SCRIPT_DIR/$BIN_FILE-keygen

rm -rf $TMP_DIR

# Run script the first time to extract version
$SCRIPT_DIR/$BIN_FILE -v
