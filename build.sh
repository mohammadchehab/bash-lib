#!/bin/bash

# Check if "dist" directory exists, create if not
DIST_DIR="./dist"
if [ ! -d "$DIST_DIR" ]; then
  mkdir -p "$DIST_DIR"
fi

OUTPUT_FILE="$DIST_DIR/bash-lib.sh"

# Delete the previous file if it exists
if [ -f "$OUTPUT_FILE" ]; then
  rm "$OUTPUT_FILE"
fi

# Start with a shebang and generated message
{
    echo '#!/bin/bash'
    echo "# Generated on $(date)"
    echo "# Author: Mohammad Chehab"
    echo "# This is a generated file. Do not modify."
} > $OUTPUT_FILE

# Function to include files and avoid duplication
include_file() {
    local file=$1
    if ! grep -q "# Begin $file" $OUTPUT_FILE; then
        echo -e "\n# Begin $file\n" >> $OUTPUT_FILE
        cat "$file" >> $OUTPUT_FILE
        echo -e "\n# End $file\n" >> $OUTPUT_FILE
    fi
}

# Add core/init.sh content
include_file "core/init.sh"

# Find and add all files ending with "*mod.sh" and "*.inc"
find . -type f \( -name "*mod.sh" -o -name "*.inc" \) | while read -r module; do
    include_file "$module"
done

echo "Build completed: $OUTPUT_FILE"