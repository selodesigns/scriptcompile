#!/bin/bash
# ScriptCompile Command - Linux (Bash) Version
# Scans a directory for various script/code files and compiles their metadata and contents into a single output file.

# Default values
default_output_file="script_compilation.txt"
default_start_dir="$(pwd)"

# Handle arguments
START_DIR="${1:-$default_start_dir}"
OUTPUT_FILE="${2:-$START_DIR/$default_output_file}"

# Ensure output file is absolute path if possible
if command -v readlink &>/dev/null; then
    OUTPUT_FILE="$(readlink -f "$OUTPUT_FILE")"
fi

# Count total files processed
total_files=0

# Create or truncate the output file with header
echo "Script Compilation created on $(date)" > "$OUTPUT_FILE"
echo "Source directory: $START_DIR" >> "$OUTPUT_FILE"
echo "=================================================================" >> "$OUTPUT_FILE"
echo >> "$OUTPUT_FILE"

# Function to process a single file
process_file() {
    local file="$1"
    
    # Skip processing the output file itself
    if [[ "$file" == "$OUTPUT_FILE" ]]; then
        return
    fi
    
    # Increment counter
    total_files=$((total_files + 1))
    
    # Display processing message
    echo "Processing: $file"
    
    # Append file info and content to output file
    echo "-----------------------------------------------------------------" >> "$OUTPUT_FILE"
    echo "FILE:   $(basename "$file")" >> "$OUTPUT_FILE"
    echo "PATH:   $(dirname "$file")" >> "$OUTPUT_FILE"
    echo "SIZE:   $(stat -c %s "$file" 2>/dev/null || wc -c < "$file") bytes" >> "$OUTPUT_FILE"
    echo "LAST MODIFIED: $(stat -c %y "$file" 2>/dev/null || date -r "$file" '+%Y-%m-%d %H:%M:%S.%N')" >> "$OUTPUT_FILE"
    echo "-----------------------------------------------------------------" >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE" 2>/dev/null
    echo >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
}

# Process each file type separately for maximum compatibility
echo "Searching for script and code files..."

# Python files
find "$START_DIR" -type f -name "*.py" -print0 2>/dev/null | while IFS= read -r -d '' file; do
    process_file "$file"
done

# JavaScript files
find "$START_DIR" -type f -name "*.js" -print0 2>/dev/null | while IFS= read -r -d '' file; do
    process_file "$file"
done

# Shell script files
find "$START_DIR" -type f -name "*.sh" -print0 2>/dev/null | while IFS= read -r -d '' file; do
    process_file "$file"
done

# TypeScript files (including .tsx)
find "$START_DIR" -type f \( -name "*.ts" -o -name "*.tsx" \) -print0 2>/dev/null | while IFS= read -r -d '' file; do
    process_file "$file"
done

# JSX files
find "$START_DIR" -type f -name "*.jsx" -print0 2>/dev/null | while IFS= read -r -d '' file; do
    process_file "$file"
done

# C/C++ files
find "$START_DIR" -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -print0 2>/dev/null | while IFS= read -r -d '' file; do
    process_file "$file"
done

# Other script types
find "$START_DIR" -type f \( -name "*.pl" -o -name "*.php" -o -name "*.rb" -o -name "*.sql" \
                            -o -name "*.cs" -o -name "*.java" -o -name "*.cmd" -o -name "*.bat" \
                            -o -name "*.ps1" -o -name "*.vbs" \) -print0 2>/dev/null | \
    while IFS= read -r -d '' file; do
        process_file "$file"
    done

# Write footer with stats
echo >> "$OUTPUT_FILE"
echo "Compilation complete!" >> "$OUTPUT_FILE"
echo "$total_files files have been compiled into:" >> "$OUTPUT_FILE"
echo "$OUTPUT_FILE" >> "$OUTPUT_FILE"

# Show completion message
if [ $total_files -eq 0 ]; then
    echo "No matching files found in $START_DIR"
else
    echo "Compilation complete! $total_files files processed."
    echo "Output saved to: $OUTPUT_FILE"
fi

# Check for help argument
if [ "$1" = "--help" ]; then
    echo "Usage: scriptcompile [directory] [output_file]"
    echo "  - directory:   Source directory to scan (default: current directory)"
    echo "  - output_file: Output file (default: script_compilation.txt in source directory)"
    exit 0
fi

exit 0
