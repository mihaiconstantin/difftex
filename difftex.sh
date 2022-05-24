#!/bin/bash

[ "$1" = "-h" -o "$1" = "--help" ] && echo "
This script uses 'latexdiff' to compare changes in '.tex' files between two
different 'git' commits (e.g., to compare the changes between HEAD~1 and HEAD).

The script takes four arguments:
  - \$1 (required): The name of the main '.tex' file to compare between commits.
  - \$2: The older commit or reference to a commit. The default is 'HEAD~1'.
  - \$3: The newer commit or reference to a commit. The default is 'HEAD'.
  - \$4: The path or directory name where to produce and store the output.

Example of how to use the script:
  difftex document.tex
  difftex document.tex HEAD~1 HEAD tmp
  difftex document.tex branch/one branch/two tmp
  difftex document.tex tag-one tag-two tmp

Description:
  - Repository: https://github.com/mihaiconstantin/difftex
  - Mihai Constantin (mihai@mihaiconstantin.com)
" && exit

# Let the script fail if arguments are not provided.
set -o nounset

# What is the entry point (i.e., the main file)?
readonly FILENAME=${1:?"Please specify the '.tex' file."}

# The `.git` references to compare (i.e., second is assumed to be more recent).
readonly REF_ONE=${2:-HEAD~1}
readonly REF_TWO=${3:-HEAD}

# Get the temporary directory location.
readonly TMP_DIR=${4:-tmp}

# Create paths.
ref_one_dir=$TMP_DIR/$REF_ONE
ref_two_dir=$TMP_DIR/$REF_TWO

# Make temporary directories.
mkdir -p $ref_one_dir
mkdir -p $ref_two_dir

# Create `git` work trees with changes at respective commits.
git worktree add $ref_one_dir $REF_ONE
git worktree add $ref_two_dir $REF_TWO

# Create build directory in the context of the more recent commit.
mkdir $ref_two_dir/build

# Create the difference `.tex` file.
latexdiff \
    --type=UNDERLINE \
    --append-textcmd="enquote" \
    --allow-spaces \
    --math-markup=3 \
    --flatten \
    $ref_one_dir/$FILENAME $ref_two_dir/$FILENAME > $ref_two_dir/build/diff.tex

# Make the `.pdf` file.
(cd $ref_two_dir && pdflatex -output-directory=build -interaction=nonstopmode -shell-escape diff.tex)

# Process the citations.
(cd $ref_two_dir && biber --output-directory=build --input-directory=build diff.bcf)

# Remake the `.pdf` file with processed citations.
(cd $ref_two_dir && pdflatex -output-directory=build -interaction=nonstopmode -shell-escape diff.tex)

# The logs say to run this again, not sure why, but I don't suppose it hurts.
(cd $ref_two_dir && pdflatex -output-directory=build -interaction=nonstopmode -shell-escape diff.tex)

# Copy output to the temporary directory.
cp -r $ref_two_dir/build/. $TMP_DIR

# Remove the `git`` work trees.
git worktree remove $ref_one_dir
git worktree remove $ref_two_dir
