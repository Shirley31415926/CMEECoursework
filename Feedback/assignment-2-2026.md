# Assignment 2 formative feedback

This feedback is organised by the relevant computing bootcamp criteria. Use it to decide what is already working, what you need to investigate, and what to revise before the cumulative submission.

The full criteria are in the [Computing Bootcamp assessment rubric](https://github.com/MulQuaBio/MQB/blob/main/content/rubrics/Computing_Bootcamp_Rubric.md).

## 1. Repository organisation and workflow discipline

- Your cleaning script, test script, raw CSV, root README and `.gitignore` are in the expected locations, but `data/silwood_trees_metadata.md` is missing. Restore the supplied metadata file and keep it unchanged.

## 2. Code completeness and functional correctness

- Your code shows a clear workflow: `main()` loads the CSV through `load_records()`, passes rows to `process_records()`, which calls `validate_record()`, and receives `(clean_records, issues)`. It then passes the cleaned records to `summarise_oaks()` and calls `write_csv()` three times. This makes the intended flow visible, although whether the workflow runs correctly from beginning to end still needs checking.
- **Verify the final output-writing step.** I could not run the checks normally because the submission contains symlinks. The generated tables were not available for checking, so this does not mean that your script failed or produced incorrect outputs. Make a separate copy of your repository in a new folder using `git clone` and confirm that the generated CSV files are not already present. Run the workflow there, then inspect all three newly generated tables. Keep a small known input as an assertion-based test of acceptance or rejection and the summary, so the intended records are checked against each output.

## 3. Code quality and style

- Your `main()` function gives the program a clear overall structure by connecting loading, processing, summarising and writing. Keep these stages distinct as you revise; use descriptive names and add short comments where the reason for a validation check or data-cleaning step is not obvious.

## 4. Documentation

- Your root README is in place. Make it useful to someone opening the repository for the first time: explain what the cleaner does, how to run the script and tests from the repository root, and which three files it creates. Test the instructions in a newly cloned copy of your repository (a separate folder created with `git clone`): enter that folder and run each README command exactly as written. If something fails, correct the command or add the missing step.

## 5. Version-control practice

- Since the previous formative feedback was added, the saved history contains 13 non-merge commits. There are many small commits, but repeated messages such as `Update README`, `Update cleaner` and `Update data cleaner` do not explain what changed or whether a particular problem was fixed.
- Before each commit, run `git diff --staged` to see exactly what will be recorded. Keep one coherent, working change per commit and write a concise message that names what changed—for example, the validation rule added, the failing test fixed or the README instruction clarified.

## 8. Basic error handling and input validation

- Your raw CSV matches the supplied input unchanged. The cleaning script, separate test file, root README and `.gitignore` are present.
- Your test file includes examples covering record validation, the accepted/rejected partition and the oak summary—a useful starting scope.
- **Make the tests detect mistakes automatically.** Your test file uses top-level checks and printed output, with no assertion-style checks. Printed results alone cannot flag a regression. Add assertions for a small valid record and an invalid record, then check their destinations and a small oak summary. Confirm that a deliberately incorrect expectation causes a test to fail.
- Restore the metadata and add meaningful assertions to `code/test_silwood_trees.py`.
- Make a separate copy of your repository in a new folder using `git clone`, enter that folder, then run the tests and cleaning script there; check the clean-record, issues and oak-count tables rather than relying only on a successful exit.
- Check that your README explains the workflow and gives working run and test commands, then commit the revisions descriptively.

## 9. Problem-solving approach and method implementation

- Before final submission, add or refine a small assertion-based test in `code/test_silwood_trees.py` using one valid and one invalid record. Check that `process_records()` places them in the cleaned and issues collections respectively, then pass the cleaned collection to `summarise_oaks()` and check that the invalid record does not contribute. Run the complete cleaner and inspect the three output files. Briefly explain this flow in your root README.
