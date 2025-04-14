#!/bin/bash

# Create _posts directory if it doesn't exist
mkdir -p _posts

# Function to convert to Pascal Case
to_pascal_case() {
    echo "$1" | sed -r 's/(^|-)([a-z])/\U\2/g'
}

# Function to add front matter to a post
add_front_matter() {
    local file=$1
    local raw_title=$(basename "$file" .md | sed 's/-/ /g')
    local title=$(to_pascal_case "$raw_title")
    local date=$(date -r "$file" "+%Y-%m-%d")
    
    # Create new file with front matter
    echo "---
layout: post
title: \"$title\"
date: $date
categories: [tech]
---" > "_posts/$(date -r "$file" "+%Y-%m-%d")-$(basename "$file")"
    
    # Append the rest of the content
    tail -n +1 "$file" >> "_posts/$(date -r "$file" "+%Y-%m-%d")-$(basename "$file")"
}

# Process each markdown file
for file in posts/*.md; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        add_front_matter "$file"
    fi
done

echo "Posts have been updated and moved to _posts directory" 