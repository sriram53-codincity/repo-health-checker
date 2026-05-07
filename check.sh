#!/bin/bash

echo "Running Repo Health Checks..."

# Check 1: README exists
if [ ! -f README.md ]; then
  echo "README.md file missing"
  exit 1
fi

# Check 2: README has more than 5 lines
lines=$(wc -l < README.md)

if [ "$lines" -lt 5 ]; then
  echo "README.md has less than 5 lines"
  exit 1
fi

# Check 3: .gitignore exists
if [ ! -f .gitignore ]; then
  echo ".gitignore file missing"
  exit 1
fi

# Check 4: No .env files
if find . -name ".env" | grep -q .; then
  echo ".env file detected"
  exit 1
fi

# Check 5: Commit message has more than 5 words

commit_msg=$(git log -1 --pretty=%B)
word_count=$(echo "$commit_msg" | wc -w)

if [ "$word_count" -lt 5 ]; then
  echo "Commit message must contain at least 5 words"
  exit 1
fi

echo "All checks passed!"
exit 0
