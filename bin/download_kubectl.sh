#!/usr/bin/env bash

# Set the variables
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TMP_DIR=$SCRIPT_DIR/tmp
BIN_FILE=kubectl

# Cleanup old remains
rm -rf $TMP_DIR
mkdir $TMP_DIR

# Get latest release and download linux zip file
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/$BIN_FILE"

chmod +x $SCRIPT_DIR/$BIN_FILE

# Cleanup remains
rm -rf $TMP_DIR

# Run script the first time to extract version
$SCRIPT_DIR/$BIN_FILE version
