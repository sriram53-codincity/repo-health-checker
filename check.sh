#!/bin/bash

echo "Running Repo Health Checks..."

error_found=0

# Check 1: README exists
if [ ! -f README.md ]; then
  echo "ERROR: README.md file missing"
  ((error_found++))
fi

# Check 2: README has more than 5 lines
if [ -f README.md ]; then
  lines=$(wc -l < README.md)

  if [ "$lines" -lt 5 ]; then
    echo "ERROR: README.md has less than 5 lines"
    ((error_found++))
  fi
fi

# Check 3: .gitignore exists
if [ ! -f .gitignore ]; then
  echo "ERROR: .gitignore file missing"
  ((error_found++))
fi

# Check 4: No .env files
if find . -name ".env" | grep -q .; then
  echo "ERROR: .env file detected"
  ((error_found++))
fi

# Check 5: Commit message has at least 5 words
commit_msg=$(git log -1 --pretty=%B)
word_count=$(echo "$commit_msg" | wc -w)

if [ "$word_count" -lt 5 ]; then
  echo "ERROR: Commit message must contain at least 5 words"
  ((error_found++))
fi

# Final Result
if [ "$error_found" -eq 1 ]; then
  echo "$error_found"
  exit 1
else
  echo "All checks passed!"
  exit 0
fi