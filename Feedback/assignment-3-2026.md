# Assignment 3 formative feedback

This feedback is organised using the [Computing Bootcamp rubric](https://mulquabio.github.io/MQB/rubrics/Computing_Bootcamp_Rubric.html). It does not award a mark; use it to decide what to revise and check before final submission.

## Criterion 1: Repository organisation & workflow discipline

- Before final submission, **Make command-line runs reproducible.** The scripts write into `results/` without first creating it, and Pound Hill includes interactive `View()` calls. These are potential obstacles when running from a newly cloned copy of your repository, where `results/` does not yet exist or without a graphical session. Ensure the output directory is created when needed and keep interactive inspection separate from the required batch run. Add `results/` and the exploratory `sandbox/` to `.gitignore`; neither is currently covered.

## Criterion 2: Code completeness & functional correctness

- Before final submission, **Complete the generalised route.** `code/run_get_TreeHeight.sh` is confirmed missing. The R program is present, but it does not replace the required shell launcher. Add the launcher and check that it passes the input filename to the R script. Test the fixed and generalised programs separately: success in one would not establish the other.

## Criterion 3: Code quality & style

As you revise, keep names descriptive, use comments to explain decisions rather than restating code, and avoid repeating the same calculation in several places.

## Criterion 4: Documentation

- Your repository contains the root README, the three R scripts and the supplied datasets; the datasets match the supplied inputs. No generated files are tracked under `results/`, and the Git history records additions and updates to code, data and documentation.
- Before final submission, **Finish the usage instructions.** Your README gives the Pound Hill command and output paths, but not commands for either tree-height route. Add these, their expected output locations, required R packages, and one ordinary and one invalid test example. More specific commit messages explaining what changed would also make revisions easier to follow.

## Criterion 5: Version-control practice

Commit each functional revision with a short message that says what changed; this makes your development easier to follow than one large final commit.

## Criterion 8: Basic error-handling & input validation

- Before final submission, **Check validation and the calculation independently.** The tree functions contain range checks, but the generalised script uses command-line arguments before checking their number. Check arguments before constructing paths, and try a missing argument and an invalid measurement. Read the error message as well as checking that no new result was written. Compare the distance limit of 100 with the released requirements rather than rejecting otherwise valid measurements unnecessarily. No independent height check is shown in the files reviewed: try the taught example call, with angle in degrees first and horizontal distance second, and compare it with a direct calculation.

## Criterion 9: Problem-solving approach & method implementation

- Your code shows a clear tree-height calculation: angle first, distance second, conversion from degrees to radians, and separate calculation and writing functions. These are useful foundations, although execution still needs to be checked.
- Your Pound Hill source explains the reshaping steps and calculates quadrat richness before averaging within plots. Your interpretation also recognises that cultivation timing alone does not establish causation. Now confirm these steps by comparing the resulting values and figure with the input data.

## Criterion 10: Learning progression demonstration

Use this feedback as a revision checklist. Make the changes in small, descriptive commits, then add a short README note explaining what you changed and how you checked it. This will make your development from this formative checkpoint visible in the final portfolio.

## Priorities before final submission

- Run commands from the directory containing `code/`, `data/` and the root `README.md`. Before final submission, rerun one ordinary and one invalid case for each tree-height route, then run Pound Hill from measurements through to saved outputs.
- Check for `results/pound_hill_plot_richness.csv` and `results/pound_hill_plot_richness.pdf`, comparing these exact paths with the filenames your script creates. Open the PDF and check labels, values and biological meaning before confirming the treatment comparisons in your comments.
- I could not safely run this commit because it contains symbolic links. Before final submission, run each required command in a newly cloned copy of the repository and record the results in your README. Check the numerical outputs, invalid-input behaviour and the Pound Hill figure.
