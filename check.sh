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

#----------------------------------------------------------------------------------------

# Check 6: No direct commits to main branch
branch=$(git branch --show-current)

if [ "$branch" = "main" ]; then
  echo "WARNING: Direct work on main branch detected"
  ((error_found++))
fi

# Check 7:Detect possible secrets Keys

if grep -r -E "API_KEY|PASSWORD|SECRET|TOKEN|AWS_ACCESS_KEY_ID" . --exclude=check.sh; then
  echo "ERROR: Possible secret keys detected"
  ((error_found++))
fi

# Final Result
if [ "$error_found" -ne 0 ]; then
  echo "$error_found"
  exit 1
else
  echo "All checks passed!"
  exit 0
fi