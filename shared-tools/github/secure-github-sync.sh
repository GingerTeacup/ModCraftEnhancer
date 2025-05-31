#!/bin/bash

# Use the existing GITHUB_PERSONAL_ACCESS_TOKEN secret and export it as GITHUB_TOKEN
# This avoids hardcoding the token in the .replit file

# Export the token from the secret environment variable
if [ -n "${GITHUB_PERSONAL_ACCESS_TOKEN}" ]; then
  export GITHUB_TOKEN="${GITHUB_PERSONAL_ACCESS_TOKEN}"
  echo "GitHub token found in environment, using for authentication"
else
  echo "Warning: GITHUB_PERSONAL_ACCESS_TOKEN not found in environment"
  echo "GitHub operations may be limited or fail"
fi

# Run the specified GitHub script or default to the sync workflow
if [ "$1" == "pull" ]; then
  # Run the pull script
  ./pull-from-github.sh
else
  # Run the sync workflow script
  ./replit-github-sync-workflow.sh
fi