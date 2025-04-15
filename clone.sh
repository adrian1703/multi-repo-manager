#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Start logging
echo -e "${CYAN}Changing directory: ${YELLOW}$SCRIPT_DIR${RESET}"
cd "$SCRIPT_DIR"

# Check if urls.txt exists
if [[ ! -f "$SCRIPT_DIR/urls.txt" ]]; then
    echo -e "${RED}Error: urls.txt file not found in $SCRIPT_DIR${RESET}"
    exit 1
fi

# Start cloning
echo -e "${CYAN}Cloning repositories listed in ${YELLOW}$SCRIPT_DIR/urls.txt${RESET}..."

while IFS= read -r repo; do
    if [[ -n "$repo" ]]; then
        echo -e "${CYAN}Cloning repository: ${YELLOW}$repo${RESET}..."
        if git clone "$repo"; then
            echo -e "${GREEN}Successfully cloned: ${YELLOW}$repo${RESET}"
        else
            echo -e "${RED}Failed to clone: ${YELLOW}$repo${RESET}"
        fi
    fi
done < "$SCRIPT_DIR/urls.txt"

echo -e "${GREEN}Finished cloning repositories.${RESET}"
