#!/bin/bash

# Define colors for the prompt
YELLOW='\033[1;33m'
RESET='\033[0m'

# Prompt the user to enter the file name
read -p "Enter the script file name: " SCRIPT_FILE

# Check if the file exists
if [ ! -f "$SCRIPT_FILE" ]; then
  echo "Error: File '$SCRIPT_FILE' not found."
  exit 1
fi

# Read the script file line by line
while IFS= read -r line; do
  # Skip empty lines and comments
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  # Simulate the prompt and display the command
  echo -e "gcpstaging54992_student@cloudshell: ${YELLOW}(qwiklabs-gcp-bc7874a631c85ad7)${RESET}$ $line"
  
  # Execute the command
  eval "$line"
done < "$SCRIPT_FILE"
