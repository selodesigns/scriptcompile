#!/bin/bash
# This script installs scriptcompile.sh as a global command 'scriptcompile'
# Usage: sudo ./install-scriptcompile.sh

set -e

SCRIPT_SOURCE="$(dirname "$0")/scriptcompile.sh"
INSTALL_PATH="/usr/local/bin/scriptcompile"

# Copy and rename
sudo cp "$SCRIPT_SOURCE" "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

echo "'scriptcompile' command installed to $INSTALL_PATH."
echo "You can now use 'scriptcompile' from anywhere."
