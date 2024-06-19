#!/bin/bash

# Variables
BASH_LIB_URL="https://raw.githubusercontent.com/mohammadchehab/bash-lib/main/dist/bash-lib.sh"
BASH_LIB_PATH="/opt/bash-lib/bash-lib.sh"
SHELL_PROFILE=""

if [ -n "$BASH_VERSION" ]; then
    SHELL_PROFILE="$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
fi

install() {
    # Create the directory if it does not exist
    sudo mkdir -p /opt/bash-lib

    # Download the merged script file
    if sudo curl -sSL $BASH_LIB_URL -o $BASH_LIB_PATH; then
        # Make the script executable
        sudo chmod +x $BASH_LIB_PATH

        # Add to shell profile
        if ! grep -q "source $BASH_LIB_PATH" "$SHELL_PROFILE"; then
            echo "source $BASH_LIB_PATH" >> "$SHELL_PROFILE"
            echo "export BASH__PATH=/opt/bash-lib" >> "$SHELL_PROFILE"
        fi

        # Source the script for the current session
        source $BASH_LIB_PATH
        export BASH__PATH=/opt/bash-lib

        echo "bash-lib installed successfully. Please restart your terminal or run 'source $SHELL_PROFILE' to apply changes."
    else
        echo "Failed to download bash-lib.sh. Please check your internet connection and try again."
        exit 1
    fi
}

uninstall() {
    # Remove the script file
    if [ -f "$BASH_LIB_PATH" ]; then
        sudo rm "$BASH_LIB_PATH"
    fi

    # Remove sourcing from shell profile
    sed -i '' '/source \/opt\/bash-lib\/bash-lib.sh/d' "$SHELL_PROFILE"
    sed -i '' '/export BASH__PATH=\/opt\/bash-lib/d' "$SHELL_PROFILE"

    echo "bash-lib uninstalled successfully. Please restart your terminal or run 'source $SHELL_PROFILE' to apply changes."
}

# Check for uninstall flag
if [ "$1" == "uninstall" ]; then
    uninstall
else
    install
fi