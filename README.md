# Repo Health Checker

Repo Health Checker is a simple DevOps automation project built using Bash scripting and GitHub Actions. This project automatically validates repository quality and security checks whenever code is pushed or a pull request is created.

## Features

- Checks if `README.md` exists
- Validates README has at least 5 lines
- Checks if `.gitignore` file exists
- Detects `.env` files for security
- Validates commit messages contain at least 5 words
- Prevents direct commits to the `main` branch
- Detects possible secret keys in repository files
- Validates GitHub Actions workflow existence
- Displays total error count if checks fail
