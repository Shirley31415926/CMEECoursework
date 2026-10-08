#!/bin/bash
# Author: Shirley Huang <xh2026@ic.ac.uk>
# Script: csvtospace.sh
# Desc: substitute the commas in the files with spaces
#       saves the output into a .txt file
# Arguments: 1-> commas text file
# Date: Oct 2026

echo "Creating a comma delimited version of $1\n ..."

cat "$1" | tr "," " " > "../results/$(basename $1).txt"

if [ $? -eq 0 ]; then
    echo "File created successfully: ../results/$(basename $1).txt"
    exit 0
else
    echo "Error creating file: ../results/$(basename $1).txt"
    exit 1
fi
