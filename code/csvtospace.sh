#!/bin/bash
# Author: Shirley Huang <xh2026@ic.ac.uk>
# Script: csvtospace.sh
# Desc: substitute the commas in the files with spaces
#       saves the output into a .txt file
# Arguments: 1-> commas text file
# Date: Oct 2026

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <input_file>" >&2
    exit 1
fi

if [[ ! -f "$1" ]]; then
    echo "Error: input file '$1' does not exist." >&2
    exit 1
fi

if [[ ! -r "$1" ]]; then
    echo "Error: input file '$1' is not readable." >&2
    exit 1
fi

echo "Creating a space delimited version of $1 ..."

mkdir -p results

output="results/$(basename "$1").txt"

if tr ',' ' ' < "$1" > "$output"; then
    echo "File created successfully: $output"
    exit 0
else
    echo "Error creating file: $output" >&2
    exit 1
fi