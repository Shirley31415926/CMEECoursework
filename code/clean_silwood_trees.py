#!/usr/bin/env python3
"""Validate and clean the synthetic Silwood tree survey."""

from __future__ import annotations

import csv, re
from pathlib import Path
from typing import Iterable

PROJECT_ROOT = Path(__name__).resolve().parents[0]
INPUT_PATH = PROJECT_ROOT / "data" / "silwood_trees_raw.csv"
RESULTS_DIR = PROJECT_ROOT / "results"

INPUT_FIELDS = [
    "record_id",
    "location",
    "genus",
    "species",
    "distance_m",
    "angle_degrees",
]
ISSUE_FIELDS = ["source_row", "record_id", "reasons"]
OAK_COUNT_FIELDS = ["species", "count"]


def load_records(path: Path = INPUT_PATH) -> list[dict[str, str]]:
    """Load survey records and check that the published columns are present."""
    with path.open(newline="", encoding="utf-8") as source:
        reader = csv.DictReader(source)
        if reader.fieldnames != INPUT_FIELDS:
            raise ValueError(
                f"Expected columns {INPUT_FIELDS}, found {reader.fieldnames}"
            )
        return list(reader)


def validate_record(
    row: dict[str, str],
    source_row: int,
    accepted_ids: set[str],
) -> tuple[dict[str, str] | None, list[str]]:
    # Define the canonical values 
    locations = {
        "silwood bottom": "Silwood Bottom",
        "nash's field": "Nash's Field",
        "manor house": "Manor House",
        "reactor wood": "Reactor Wood"
    }
    genera = {
        "quercus": "Quercus",
        "acer": "Acer",
        "betula": "Betula",
        "fagus": "Fagus",
        "fraxinus": "Fraxinus"
    }
    species_names = {
        "robur": "robur",
        "petraea": "petraea",
        "pseudoplatanus": "pseudoplatanus",
        "pendula": "pendula",
        "sylvatica": "sylvatica",
        "excelsior": "excelsior"
    }
    taxon_pairs = [
        "quercus robur",
        "quercus petraea",
        "acer pseudoplatanus",
        "betula pendula",
        "fagus sylvatica",
        "fraxinus excelsior"
    ]
    # Rejectoin reasons
    rejection = []
    # 1. record_id
    record_id = row["record_id"].strip()
    if not record_id:
        rejection.append("missing record_id")
    elif not re.fullmatch(r"ST\d{3}", record_id):
        rejection.append("invalid record_id")
    elif record_id in accepted_ids:
        rejection.append("duplicate record_id")
    else:
        if source_row < 10:
            row["record_id"] = f"ST00{source_row}"
        elif source_row <100:
            row["record_id"] = f"ST0{source_row}"
        else:
            row["record_id"] = f"ST{source_row}"

    # 2. location
    location = row["location"].strip()
    if not location:
        rejection.append("missing location")
    elif location.casefold() not in locations:
        rejection.append("invalid location")
    else:
        row["location"] = locations[location.casefold()]
    # 3. genus
    genus = row["genus"].strip()
    if not genus:
        rejection.append("missing genus")
    elif genus.casefold() not in genera:
        rejection.append("invalid genus")
    else:
        row["genus"] = genera[genus.casefold()]
    # 4. species
    species = row["species"].strip()
    if not species:
        rejection.append("missing species")
    elif species.casefold() not in species_names:
        rejection.append("invalid species")
    else:
        row["species"] = species_names[species.casefold()]
    # 5. genus/species combination
    if genus.casefold() in genera and species.casefold() in species_names:
        taxon_pair = genus.casefold() + " " + species.casefold()
        if not taxon_pair in taxon_pairs:
            rejection.append("invalid genus/species combination")
    # 6. distance
    distance = row["distance_m"].strip()
    if not distance:
        rejection.append("missing distance_m")
    else:
        try:
            distance = float(distance)
            if not 0 < distance < 90:
                rejection.append("distance_m out of range")
        except ValueError:
            rejection.append("invalid distance_m")
    # 7. angle
    angle = row["angle_degrees"].strip()
    if not angle:
        rejection.append("missing angle_degrees")
    else:
        try:
            angle = float(angle)
            if not 0 < angle < 90:
                rejection.append("angle_degrees out of range")
        except ValueError:
            rejection.append("invalid angle_degrees")

    # Return reasons
    if rejection == []:
        return row, None
    else:
        return row, rejection

    """Return a cleaned record or its ordered rejection reasons."""
    raise NotImplementedError("Complete the record validation")



def process_records(
    rows: Iterable[dict[str, str]],
) -> tuple[list[dict[str, str]], list[dict[str, str]]]:
    accepted_ids = set()
    source_row = 0
    clean_records = []
    issues = []
    for row in rows:
        source_row = source_row + 1 # locate where the row is
        valid_output = validate_record(row, source_row, accepted_ids)
        valid_row = valid_output[0]
        valid_issue = valid_output[1]
        accepted_ids.add(valid_row["record_id"])
        if valid_row is not None:
            clean_records.append(valid_row)
        issue = dict(source_row = source_row, record_id = valid_row["record_id"],reasons = valid_issue)
        if valid_row is not None:
            issues.append(issue)
    return clean_records, issues
    """Separate accepted records from rejected-row reports."""
    raise NotImplementedError("Complete the record-processing workflow")


def summarise_oaks(clean_records: Iterable[dict[str, str]]) -> list[dict[str, str]]:
    sum_oaks = []
    accepted_oak = set()
    for record in clean_records:
        species = record["species"]
        if record["genus"] == "Quercus":
            if species not in accepted_oak:
                oak = dict(species = species, count = 1)
                accepted_oak.add(species)
                sum_oaks.append(oak)
            else:
                for oak in sum_oaks:
                    if oak["species"] == species:
                        oak["count"] += 1
                        
    return sum_oaks
    """Count accepted oak records by species."""
    raise NotImplementedError("Complete the oak summary")


def write_csv(
    path: Path,
    fieldnames: list[str],
    rows: Iterable[dict[str, str]],
) -> None:
    """Replace a CSV file with the supplied rows."""
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as destination:
        writer = csv.DictWriter(destination, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    """Run the complete validation workflow."""
    clean_records, issues = process_records(load_records())
    oak_counts = summarise_oaks(clean_records)

    write_csv(
        RESULTS_DIR / "silwood_trees_clean.csv",
        INPUT_FIELDS,
        clean_records,
    )
    write_csv(
        RESULTS_DIR / "silwood_tree_issues.csv",
        ISSUE_FIELDS,
        issues,
    )
    write_csv(
        RESULTS_DIR / "oak_species_counts.csv",
        OAK_COUNT_FIELDS,
        oak_counts,
    )


if __name__ == "__main__":
    main()
