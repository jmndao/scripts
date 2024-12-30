#!/bin/bash

set -e

# Default configuration
DEFAULT_ROOT="$HOME/Documents/projects"
CONFIG_FILE="$HOME/Documents/scripts/update-version.conf"

# Load configuration if the file exists
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

# Use the root path from the config file or fallback to the default
ROOT_PATH="${ROOT_PATH:-$DEFAULT_ROOT}"

# Functions
increment_version() {
    local version="$1"
    local -a parts
    IFS='.' read -ra parts <<< "$version"

    # Increment patch (default)
    parts[2]=$((parts[2] + 1))
    echo "${parts[0]}.${parts[1]}.${parts[2]}"
}

show_help() {
    echo "Usage: $0 [-i|--increment] [-v|--version <newVersion>] [-d|--dir <relativeDirectory>]"
    echo ""
    echo "Options:"
    echo "  -i, --increment       Increment the current version (patch by default)."
    echo "  -v, --version VALUE   Set a specific version (e.g., 1.2.3)."
    echo "  -d, --dir DIRECTORY   Specify the relative directory under the root path (default: root path)."
    echo "  -h, --help            Show this help message."
    exit 1
}

# Parse arguments
RELATIVE_DIR="."
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--increment) INCREMENT=true ;;
        -v|--version) NEW_VERSION="$2"; shift ;;
        -d|--dir) RELATIVE_DIR="$2"; shift ;;
        -h|--help) show_help ;;
        *) echo "Unknown parameter: $1"; show_help ;;
    esac
    shift
done

# Determine full directory path
PACKAGE_DIR="$ROOT_PATH/$RELATIVE_DIR"

# Validate directory
PACKAGE_FILE="$PACKAGE_DIR/package.json"
if [[ ! -f "$PACKAGE_FILE" ]]; then
    echo "Error: $PACKAGE_FILE not found!"
    exit 1
fi

# Read current version
CURRENT_VERSION=$(jq -r '.version' "$PACKAGE_FILE")
if [[ -z "$CURRENT_VERSION" ]]; then
    echo "Error: Failed to read the current version!"
    exit 1
fi

# Determine the new version
if [[ "$INCREMENT" == true ]]; then
    NEW_VERSION=$(increment_version "$CURRENT_VERSION")
elif [[ -z "$NEW_VERSION" ]]; then
    echo "Error: Either -i or -v must be specified."
    show_help
fi

# Update the version in package.json
jq --arg newVersion "$NEW_VERSION" '.version = $newVersion' "$PACKAGE_FILE" > "$PACKAGE_FILE.tmp" && mv "$PACKAGE_FILE.tmp" "$PACKAGE_FILE"

echo "Updated version in $PACKAGE_FILE: $CURRENT_VERSION → $NEW_VERSION"
