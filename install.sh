#!/bin/bash

# Define paths.
TMP_DIR=~/.difftex-tmp
BIN_DIR=/usr/local/bin

# Create temporary directory.
mkdir -p $TMP_DIR

# User feedback.
echo "Cloning the 'mihaiconstantin/difftex' repository..."

# Clone the repository.
git clone --depth 1 https://github.com/mihaiconstantin/difftex.git $TMP_DIR &> /dev/null

# User feedback.
echo "Installing script to $BIN_DIR/difftex..."

# Copy script to `bin` folder.
sudo cp $TMP_DIR/difftex.sh $BIN_DIR/difftex

# Set the permissions.
sudo chmod 755 $BIN_DIR/difftex
sudo chmod u+x $BIN_DIR/difftex

# User feedback.
echo "Removing temporary directory $TMP_DIR..."

# Cleanup.
rm -rf $TMP_DIR

# User feedback.
echo "'difftex' tool installed. Type 'difftex --help' for instructions."
