# CMEE Bootcamp Coursework

## Purpose
This repository contains coursework assignments for the Computational Methods in Ecology and Evolution (CMEE) bootcamp, part of the Master's programme at Imperial College London.

### Assignment 1: FASTA Practical
## Project structure
```text
CMEECoursework/
    README.md
    code/
        tabtocsv.sh
        csvtospace.sh
        unixPrac1.txt
    data/
        fasta/
            407228326.fasta
            407228412.fasta
            e_coli.fasta
        temperatures/
            1800.csv
            1801.csv
            1802.csv
            1803.csv
    results/
    sandbox/
    .gitignore
```
## Usage
Run the commands from the project root directory.
```bash
CMEECourse
```


### Assignment 2: Silwood Tree Survey
This assignment validates and cleans the synthetic tree survey data provided in data/silwood_trees_raw.csv.
The script code/clean_silwood_trees.py validates: 
- record_id
- location
- genus
- species
- distance_m
- angle_degrees
It standardises recognised values and records all applicable rejection reasons for invalid records, including:
1. `missing record_id`
2. `invalid record_id`
3. `duplicate record_id`
4. `missing location`
5. `invalid location`
6. `missing genus`
7. `invalid genus`
8. `missing species`
9. `invalid species`
10. `invalid genus/species combination`
11. `missing distance_m`
12. `invalid distance_m`
13. `distance_m out of range`
14. `missing angle_degrees`
15. `invalid angle_degrees`
16. `angle_degrees out of range`

## Project Structure
```text
CMEECoursework/
├── README.md
├── .gitignore
├── data/
│   └── silwood_trees_raw.csv
├── code/
│   ├── clean_silwood_trees.py
│   └── test_silwood_trees.py
├── results/
└── sandbox/
```
## Algorithm Plan
1. Read the raw CSV and check its column names and order.
2. Process records after removing surrounding whitespace, validating each field.
3. Standardise recognised location, genus, and species names.
4. Reject records with validation errors and record their source row numbers and rejection reasons.
4. Accept valid records and reserve their record IDs to detect later duplicates.
5. Sort accepted records by record ID and count accepted oak records by species.
6. Write the three output CSV files to results/:
    - silwood_trees_clean.csv
    - silwood_tree_issues.csv
    - oak_species_counts.csv

### Pseudocode
Read the raw CSV
Check the column names

For each record:
    Validate the ID, location, genus, species, distance and angle
    Check the genus/species combination
    If any validation errors exist:
        Save the record's source row and rejection reasons
    Otherwise:
        Save the cleaned record
        Reserve its ID
        
Sort accepted records by ID
Count accepted Quercu(oak) records by species
Write the three result files

## Usage
Run all commands from the project root directory.
Run the tree survey cleaner:
python3 code/clean_silwood_trees.py

The script creates the results/ directory files:
results/silwood_trees_clean.csv — accepted, cleaned records sorted by record ID.
results/silwood_tree_issues.csv — rejected records, source row numbers, and rejection reasons.
results/oak_species_counts.csv — counts of accepted oak records by species.

## Requirements
- Python 3.9.6
- Bash
- Unix-like terminal, such as macOS Terminal or Linux shell

## Data 
Data is from mhasoba's MQB https://github.com/MulQuaBio/MQB.git content/ 

## Authors
Shirley Huang
