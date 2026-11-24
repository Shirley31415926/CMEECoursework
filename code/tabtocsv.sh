#!/bin/bash
# Author: Shirley Huang <xh2026@ic.ac.uk>
# Script: tabtocsv.sh
# Desc: substitute the tabs in the files with commas
#       saves the output into a .csv file
# Arguments: 1-> tab delimited file
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

echo "Creating a comma delimited version of $1 ..."

mkdir -p results

output="results/$(basename "$1").csv"

if tr '\t' ',' < "$1" > "$output"; then
    echo "File created successfully: $output"
    exit 0
else
    echo "Error creating file: $output" >&2
    exit 1
fi