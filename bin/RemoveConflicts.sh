#!/bin/bash

# Find and review Syncthing conflict files
#
# When Syncthing cannot automatically merge changes, it creates a
# conflict file by inserting
#
#   .sync-conflict-<timestamp>-<id>
#
# before the original file extension.
#
# Example:
#
#   notes.txt
#   notes.sync-conflict-20260101-120000-ABCD123.txt
#
# For each conflict file found under $root_dir, this script locates the
# corresponding original file, displays a diff, and prompts whether to
# delete the conflict file.

root_dir=~/Documents/PKM
conflict_files=$(find "$root_dir" \
    -iname "*sync-conflict-*" \
    -type f \
    -not -path "*/.trash/*" \
    -not -path "*/.obsidian/*")

if [[ -z "$conflict_files" || "$conflict_files" =~ ^[[:space:]]*$ ]]; then
    echo "No conflict files found"
    exit 0
fi

while IFS= read -r conflict_file; do
    # Extract the base file name without the conflict suffix
    #
    # Remove the sync-conflict suffix while preserving the extension.
    # Since the filename may contain multiple `.`, reverse the string
    # so we can operate on the first two `.` characters instead of
    # the last two.
    base_name=$(basename "$conflict_file" | rev | sed 's/\.[^.]*\././' | rev)
    dir_name=$(dirname "$conflict_file")

    # Locate the non-conflict version of the file (stop after first match)
    original_file=$(
        find "$dir_name" \
            -iname "$base_name" \
            -not -path "$conflict_file" \
            -print -quit
    )

    if [[ -z "$original_file" ]]; then
        echo "Could not find matching file for $conflict_file"
        continue
    fi

    echo "-------------------------------------------------"
    echo "--   Conflict File: $conflict_file"
    echo "--   Base name:     $base_name"
    echo "--   Original file: $original_file"
    echo "-------------------------------------------------"

    if cmp -s "$original_file" "$conflict_file"; then
        echo "Files are identical. Safe to delete the conflict copy."
    else
        diff --unified --color=auto "$original_file" "$conflict_file"
    fi

    while true; do
        read -r -p "Delete conflict file? [y]es/[n]o/[q]uit: " response </dev/tty

        case $response in
        [Yy]*)
            rm "$conflict_file"
            echo "Deleted $conflict_file"
            break
            ;;
        [Nn]*)
            echo "Skipping $conflict_file"
            break
            ;;
        [Qq]*)
            echo "Exiting"
            exit 0
            ;;
        *)
            echo "Invalid input"
            ;;
        esac
    done
done <<<"$conflict_files"
