#!/bin/bash
changed_files=$(git diff --cached --name-only --diff-filter=ACM | grep '\.py$')

if [ -z "$changed_files" ]; then
    exit 0
fi

if ! uvx ruff@latest check --fix --force-exclude $changed_files; then
    echo "ruff found errors. Please review the changes before committing."
    exit 1
fi

if uvx ruff@latest format --force-exclude $changed_files | grep -q "reformatted"; then
    echo "ruff found errors. Please review the changes before committing."
    exit 1
fi
