#!/usr/bin/env python3
"""Assertion tests for the Silwood tree cleaner."""

import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

from clean_silwood_trees import (
    validate_record,
    process_records,
    summarise_oaks,
)


def make_record(**changes):
    """Create a valid test record, with optional field changes."""
    record = {
        "record_id": "ST001",
        "location": "Silwood Bottom",
        "genus": "Quercus",
        "species": "robur",
        "distance_m": "12.5",
        "angle_degrees": "35",
    }
    record.update(changes)
    return record


class TestSilwoodTrees(unittest.TestCase):

    def test_valid_record_is_cleaned(self):
        row = make_record(
            location=" silwood bottom ",
            genus=" quercus ",
            species=" ROBUR "
        )

        cleaned, reasons = validate_record(row, 2, set())

        self.assertEqual(reasons, [])
        self.assertEqual(cleaned["location"], "Silwood Bottom")
        self.assertEqual(cleaned["genus"], "Quercus")
        self.assertEqual(cleaned["species"], "robur")
        self.assertEqual(cleaned["record_id"], "ST001")

    def test_missing_and_unrecognised_values(self):
        row = make_record(
            record_id="",
            location="Near Hamilton",
            species=""
        )

        cleaned, reasons = validate_record(row, 2, set())

        self.assertIsNone(cleaned)
        self.assertIn("missing record_id", reasons)
        self.assertIn("invalid location", reasons)
        self.assertIn("missing species", reasons)

    def test_invalid_measurements(self):
        row = make_record(
            distance_m="not-a-number",
            angle_degrees="not-a-number"
        )

        cleaned, reasons = validate_record(row, 2, set())

        self.assertIsNone(cleaned)
        self.assertIn("invalid distance_m", reasons)
        self.assertIn("invalid angle_degrees", reasons)

    def test_measurements_out_of_range(self):
        row = make_record(
            distance_m="101",
            angle_degrees="91"
        )

        cleaned, reasons = validate_record(row, 2, set())

        self.assertIsNone(cleaned)
        self.assertIn("distance_m out of range", reasons)
        self.assertIn("angle_degrees out of range", reasons)

    def test_duplicate_identifier(self):
        row = make_record()
        accepted_ids = {"ST001"}

        cleaned, reasons = validate_record(
            row, 2, accepted_ids
        )

        self.assertIsNone(cleaned)
        self.assertIn("duplicate record_id", reasons)

    def test_multiple_validation_errors(self):
        row = make_record(
            record_id="ST002",
            location="Near Hamilton",
            species="pseudoplatanus",
            distance_m="200",
            angle_degrees="-10"
        )

        cleaned, reasons = validate_record(row, 2, set())

        self.assertIsNone(cleaned)
        self.assertIn("invalid location", reasons)
        self.assertIn("invalid genus/species combination", reasons)
        self.assertIn("distance_m out of range", reasons)
        self.assertIn("angle_degrees out of range", reasons)

    def test_process_records(self):
        rows = [
            make_record(record_id="ST001"),
            make_record(
                record_id="ST001",
                location="Near Hamilton"
            ),
            make_record(
                record_id="ST003",
                genus="Acer",
                species="pseudoplatanus"
            ),
        ]

        clean_records, issues = process_records(rows)

        self.assertEqual(len(clean_records), 2)
        self.assertEqual(len(issues), 1)

        self.assertEqual(
            [r["record_id"] for r in clean_records],
            ["ST001", "ST003"]
        )

        self.assertEqual(issues[0]["source_row"], 3)
        self.assertIn(
            "duplicate record_id",
            issues[0]["reasons"]
        )

    def test_summarise_oaks(self):
        records = [
            make_record(species="robur"),
            make_record(record_id="ST002", species="robur"),
            make_record(
                record_id="ST003",
                species="petraea"
            ),
            make_record(
                record_id="ST004",
                genus="Quercuss",
                species="robur"
            ),
            make_record(
                record_id="ST005",
                genus="Acer",
                species="pseudoplatanus"
            ),
        ]

        result = summarise_oaks(records)

        self.assertEqual(
            result,
            [
                {"species": "petraea", "count": 1},
                {"species": "robur", "count": 2},
            ]
        )

    def test_no_oaks(self):
        records = [
            make_record(
                genus="Acer",
                species="pseudoplatanus"
            )
        ]

        self.assertEqual(summarise_oaks(records), [])

    # import has no side effects
    def test_import_and_repeated_runs(self):
        project_root = Path(__file__).resolve().parents[1]
        cleaner = project_root / "code" / "clean_silwood_trees.py"
        raw_data = project_root / "data" / "silwood_trees_raw.csv"

        with tempfile.TemporaryDirectory() as temporary:
            temp_root = Path(temporary)
            temp_code = temp_root / "code"
            temp_data = temp_root / "data"

            temp_code.mkdir()
            temp_data.mkdir()

            shutil.copy2(cleaner, temp_code / cleaner.name)
            shutil.copy2(raw_data, temp_data / raw_data.name)

            env = os.environ.copy()
            env["PYTHONPATH"] = str(temp_code)

            # Importing must not create results or run main().
            subprocess.run(
                [sys.executable, "-c", "import clean_silwood_trees"],
                cwd=temp_root,
                env=env,
                check=True
            )

            self.assertFalse((temp_root / "results").exists())

            subprocess.run(
                [sys.executable, str(temp_code / cleaner.name)],
                cwd=temp_root,
                env=env,
                check=True
            )

            output_names = [
                "silwood_trees_clean.csv",
                "silwood_tree_issues.csv",
                "oak_species_counts.csv",
            ]

            first_results = {
                name: (temp_root / "results" / name).read_bytes()
                for name in output_names
            }

            # Run the cleaner a second time.
            subprocess.run(
                [sys.executable, str(temp_code / cleaner.name)],
                cwd=temp_root,
                env=env,
                check=True
            )

            second_results = {
                name: (temp_root / "results" / name).read_bytes()
                for name in output_names
            }

            self.assertEqual(first_results, second_results)


if __name__ == "__main__":
    unittest.main()
