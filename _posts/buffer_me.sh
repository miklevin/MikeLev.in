#!/bin/bash

# List files matching the pattern YYYY-MM-DD-[wildcardanything].md
for file in ????-??-??-*.md; do
    # Check if the file exists to avoid output when no match is found
    if [[ -e "$file" ]]; then
        echo "xc $file"
    fi
done
