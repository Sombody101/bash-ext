#!/bin/bash

count=0
changed=()

git submodule foreach '
    echo "Updating submodule: $path"
    bash -c "
        git checkout main  # Switch to the main branch (replace with the appropriate branch name)
        git pull origin main  # Update to the latest commit on the main branch
        echo \"--------------\"
        count=$((count + 1))
        if [[ -n \$(git status --porcelain) ]]; then
            changed+=(\"\$(basename \"\$path\")\")
        fi
    "
'

echo "$count submodules changed"

for module in "${changed[@]}"; do
    printf "\t%s\n" "$module"
done

git add .
echo "git add ." # Just so I remember it's happening
echo "Files added"
