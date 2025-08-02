#!/usr/bin/env -S bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

repos_file_location="$SCRIPT_DIR/repos.yaml"

echo -e "${CYAN}Changing directory: ${YELLOW}$SCRIPT_DIR${RESET}"
cd "$SCRIPT_DIR" || exit

echo -e "${CYAN}Cloning repositories listed in ${YELLOW}$SCRIPT_DIR/repos.yaml${RESET}..."
yq ".repos[].url" "$repos_file_location" |
  while read -r repo; do
    if [ -d "$SCRIPT_DIR/$(basename "$repo" .git)" ]; then
      echo -e "${CYAN}Repository already exists; skipping: ${YELLOW}$repo${RESET}..."
    else
      echo -e "${CYAN}Cloning repository: ${YELLOW}$repo${RESET}..."
      if git clone "$repo"; then
        echo -e "${GREEN}Successfully cloned: ${YELLOW}$repo${RESET}"
      else
        echo -e "${RED}Failed to clone: ${YELLOW}$repo${RESET}"
      fi
    fi
  done

echo -e "${GREEN}Finished cloning repositories.${RESET}"
