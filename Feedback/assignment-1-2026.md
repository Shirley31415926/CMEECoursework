# Assignment 1 feedback - Xiaolin Huang

**Formative feedback | Rubric 2026.2**

The Unix notes describe the stages of the length and motif pipelines, and the history includes identifiable script and FASTA revisions. Both converter files also have basic argument checking. There is useful work here, but it could only be reviewed from source in this assessment.

The repository tracks sandbox/.venv, including symlinks that the isolated collector cannot copy as an unchanged submission. No student command was launched. Remove the disposable environment from version control and ignore it; keep the scripts and required data. This collection limitation is not a measured failure of your conversion algorithms.

The Unix file first changes into data/fasta and then uses bare filenames. Each numbered answer should instead work independently from code/, without relying on that earlier change of directory. Correct the explanations too: tail +2 starts at the second line, the length method includes ambiguity positions, and Bash/printf substitution is not a Python f-string.

The converters need to create the correct results directory, quote the input inside basename, check readability and send errors to stderr. Add the missing own TSV. In the README, CMEECourse/code is a path, not an executable command; give exact run examples, dependencies including bc, test outcomes and any help account. Once the environment is untracked, a new snapshot and run will be needed to verify the behaviour. Keep the next revision small and reproducible rather than tied to your current terminal setup.

---

## Project structure

Relevant tracked layout (simplified; missing required paths are marked):

```text
README.md
.gitignore
code/  unixPrac1.txt, tabtocsv.sh, csvtospace.sh
data/fasta/  3 required files present
data/temperatures/  4 required files present
data/tab-example.tsv [missing]
results/  placeholder only
sandbox/  3503 files tracked
```

The main root layout and required supplied inputs are present, but the own TSV is missing. results/ contains only a placeholder. Thousands of files from sandbox/.venv are tracked, including the symlinks that prevented unchanged isolated collection.

Untrack the local virtual environment and disposable sandbox material, and add ignore rules for them and results/. Keep actual classroom source in code/. Add the own TSV and make the README describe a checkout that works without your local environment. The placeholder itself is not a generated output problem.

**Assessed snapshot:** `7adbb0728596a2ba25925c436d5f034b4c77917c`
