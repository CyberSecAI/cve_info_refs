#!/bin/bash

# Find files >= 10MB in the CVE directory structure and add them to .gitignore
# -not -path '*/\.*' excludes hidden directories and their contents
find ./ -not -path '*/\.*' -type f -size +10M -print0 | while IFS= read -r -d '' file; do
    # Skip data_out/cve_descriptions.json
    if [[ "$file" == "./data_out/cve_descriptions.json" ]]; then
        echo "Skipping: $file"
        continue
    fi

    # Get the relative path for .gitignore
    relative_path=${file#../}
    
    # Check if the file is already in .gitignore
    if ! grep -Fxq "$relative_path" .gitignore; then
        echo "Adding to .gitignore: $relative_path"
        echo "$relative_path" >> .gitignore
    else
        echo "Already in .gitignore: $relative_path"
    fi
done