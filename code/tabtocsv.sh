#!/bin/bash
# Author: Shirley Huang <xh2026@ic.ac.uk>
# Script: tabtocsv.sh
# Desc: substitute the tabs in the files with commas
#       saves the output into a .csv file
# Arguments: 1-> tab delimited file
# Date: Oct 2026

echo "Creating a comma delimited version of $1\n ..."

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <1>" >&2
    exit 1
fi

if [[ ! -f "$1" ]]; then
    echo "Error: input file '$1' does not exist." >&2
    exit 1
fi

cat "$1" | tr "\t" "," > "../results/$(basename $1).csv"

if [ $? -eq 0 ]; then
    echo "File created successfully: ../results/$(basename $1).csv"
    exit 0
else
    echo "Error creating file: ../results/$(basename $1).csv"
    exit 1
fi
 
