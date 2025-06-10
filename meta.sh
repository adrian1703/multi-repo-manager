#!/usr/bin/env -S bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

repos_file_location="$SCRIPT_DIR/repos.yaml"

if [[ -z "$1" ]]; then
  CMD="pwd"
  echo -e "${YELLOW}WARN: No command provided!${RESET}"
  echo -e "${CYAN}DEFAULT:${RESET} ${GREEN}${CMD}${RESET}"
else
  CMD="$*"
  echo -e "${GREEN}Command provided: '${CMD}'${RESET}"
fi



yq ".repos[].name" "$repos_file_location" |
while read -r directory; do
  cd "$SCRIPT_DIR/$directory" || {
    echo -e "${RED}Failed to cd to $directory. Skipping...${RESET}"
    continue
  }
  echo -e "${GREEN}Executing '${CMD}' in: $directory${RESET}"
  eval "$CMD"
done
