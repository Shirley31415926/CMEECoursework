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
CMEECoursework
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
```bash
    silwood_trees_clean.csv
```
```bash
    silwood_tree_issues.csv
```
```bash
    oak_species_counts.csv
```

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
```bash
python3 code/clean_silwood_trees.py
```
The script creates the results/ directory files:
```bash
results/silwood_trees_clean.csv 
# accepted, cleaned records sorted by record ID
```
```bash
results/silwood_tree_issues.csv 
# rejected records, source row numbers, and rejection reasons
```
```bash
results/oak_species_counts.csv
# counts of accepted oak records by species
```
## Testing
Run the automated tests from the project root:
```bash
python3 -m unittest code/test_silwood_trees.py
```

### Assignment 3: Calculate tree heights & Analyse Pound Hill species richness.
This assignment contains two project. The first one calculates tree heights and the sencond one analyses Pound Hill species richness. Both data are provided in repository ```data/ ```.
The script:
```bash
code/TreeHeight.R 
code/get_TreeHeight.R
code/pound_hill_analysis.R
```

## Project Structure
```text
CMEECoursework/
├── README.md
├── .gitignore
├── data/
│   ├── trees.csv
│   ├── pound_hill_data.csv
│   └── pound_hill_meta_data.csv
├── code/
│   ├── TreeHeight.R
│   ├── get_TreeHeight.R
│   └── pound_hill_analysis.R
├── results/
└── sandbox/
```
## Algorithm Plan
1. Read the raw CSV
2. Replace blank values with zeros
3. Convert from wide to long form and to a derived table
4. Determine the number of distinct species, quadrats and plots
5. Make a plot-level summary containing Cultivation, Block, Plot and MeanRichness
6. Write the result files
7. Draw a figure comparing plot-level mean richness among the three cultivation treatments
8. Save the figure

### Pseudocode
Read the raw CSV
Replace blank values with zeros
Convert from wide to long form and to a derived table
Determine the number of distinct species, quadrats and plots
Make a plot-level summary containing Cultivation, Block, Plot and MeanRichness
Write the result files
Draw a figure comparing plot-level mean richness among the three cultivation treatments
Save the figure


## Usage
Run all commands from the project root directory.
Run the Pound Hill analysis script:
```bash
Rscript code/pound_hill_analysis.R
```
The script creates the results/ directory files:
```bash
results/pound_hill_plot_richness.csv 
# A plot-level summary containing Cultivation, Block, Plot and MeanRichness
```
```bash
results/pound_hill_plot_richness.pdf 
# A figure comparing plot-level mean richness among the three cultivation treatments
```


## Requirements
- Python 3.9.6
- Bash
- R
- Unix-like terminal, such as macOS Terminal or Linux shell

## Data 
Data is from mhasoba's MQB https://github.com/MulQuaBio/MQB.git content/ 

## Authors
Shirley Huang
