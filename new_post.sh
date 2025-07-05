#!/bin/bash

# Get the current date
DATE=$(date +%Y-%m-%d)

# Prompt for title and tags
read -p "Enter the title of the post: " title
read -p "Enter tags (comma-separated): " tags

# Sanitize the title for the filename
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

# Create the markdown file
POST_FILE="_posts/$DATE-$slug.md"
echo "---" > "$POST_FILE"
echo "layout: default" >> "$POST_FILE"
echo "title: "$title"" >> "$POST_FILE"
echo "date: $DATE" >> "$POST_FILE"
echo "tags: [$tags]" >> "$POST_FILE"
echo "---" >> "$POST_FILE"

echo "Created post: $POST_FILE"

# Create tag files if they don't exist
IFS=',' read -ra TAG_ARRAY <<< "$tags"
for tag in "${TAG_ARRAY[@]}"; do
  # Trim whitespace
  tag=$(echo "$tag" | sed 's/^[ 	]*//;s/[ 	]*$//')
  TAG_FILE="tags/$tag.html"
  if [ ! -f "$TAG_FILE" ]; then
    echo "---" > "$TAG_FILE"
    echo "layout: default" >> "$TAG_FILE"
    echo "title: "Tag: $tag"" >> "$TAG_FILE"
    echo "---" >> "$TAG_FILE"
    echo "<h1>Tag: $tag</h1>" >> "$TAG_FILE"
    echo "<ul>" >> "$TAG_FILE"
    echo "{% for post in site.tags.$tag %}" >> "$TAG_FILE"
    echo "  <li>" >> "$TAG_FILE"
    echo "    <a href="{{ post.url }}">{{ post.title }}</a> ({{ post.date | date_to_string }})" >> "$TAG_FILE"
    echo "  </li>" >> "$TAG_FILE"
    echo "{% endfor %}" >> "$TAG_FILE"
    echo "</ul>" >> "$TAG_FILE"
    echo "Created tag file: $TAG_FILE"
  fi
done
