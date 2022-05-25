# `difftex` - compare `LaTeX` files in `git` repositories

<div align="center">
    <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/mihaiconstantin/difftex">
    <img alt="Repository Status" src="https://img.shields.io/badge/repo%20status-WIP-yellow">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/mihaiconstantin/difftex">
    <img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/mihaiconstantin/difftex?style=social">
</div>

<br>

`difftex` is a shell script wrapper around
[`latexdiff`](https://ctan.org/pkg/latexdiff?lang=en) that can be used to
compare changes in `.tex` files between two different `git` commits (e.g., to
compare the changes between `HEAD~1` and `HEAD`). It shares a similar purpose as
[`Git Latexdiff`](https://gitlab.com/git-latexdiff/git-latexdiff) but it is
likely narrower in scope. `difftex` is build for `macOS` and other `Unix`-based
operating systems.

## Installation

`difftex` can be installed by running:

```bash
curl https://raw.githubusercontent.com/mihaiconstantin/difftex/main/install.sh | sudo bash
```

The command above will perform the following steps:

1. Clone the `mihaiconstantin/difftex` repository into a temporary directory.
2. Copy `difftex.sh` to `/usr/local/bin/difftex`.
3. Adjust permissions and make `difftex` executable.
4. Remove the temporary directory.

### Uninstalling

To uninstall `difftex` simply remove the script as:

```bash
sudo rm /usr/local/bin/difftex
```

### Updating

To update `difftex` just re-run installation command above which will replace
the current `/usr/local/bin/difftex` with the newest one from the GitHub
repository.

## Usage

The script takes four arguments:

- `$1` **(required)**: The name of the main `.tex` file to compare between commits.
- `$2`: The older commit or reference to a commit. The default is `HEAD~1`.
- `$3`: The newer commit or reference to a commit. The default is `HEAD`.
- `$4`: The path or directory name where to produce and store the output. The default is `./tmp`

Example of how to use the script:

```bash
difftex file.tex
difftex file.tex HEAD~1 HEAD tmp
difftex file.tex branch-one branch-two tmp
difftex file.tex tag-one tag-two tmp
```

The annotated `.pdf` document can be found in the output folder (i.e., `./tmp`
or the one specified).

### Custom `latexdiff` options

In more advances cases, users may want to customize what kind of markup is
generated. To achieve this,
[`latexdiff`](https://ctan.org/pkg/latexdiff?lang=en) offers a wide range of
options (i.e., see `latexdiff --help`). To maximize compatibility across
projects, `difftex` runs the `latexdiff` command with more or less the default
options, i.e.,:

```bash
latexdiff \
    --type=UNDERLINE \
    --append-textcmd="enquote" \
    --allow-spaces \
    --math-markup=3 \
    --flatten \

    # Reminder of the 'latexdiff' command.
    ...
```

If a specific project requires running `latexdiff` with different or more
options, one can edit the file `/usr/local/bin/difftex` to adjust the
`latexdiff` command call accordingly. For example, adding the following (i.e.,
see below) will instruct `latexdiff` to include markup for changes in the
*Abstract* section of a manuscript.

``` bash
--append-context2cmd="abstract" \
```

If one is interested in ignoring changes for entire environments (e.g., the
`figure` environment), the following trick can be used (i.e., see [this
answer](https://tex.stackexchange.com/a/73649/134807) for more information):

```bash
--config="PICTUREENV=(?:picture|DIFnomarkup|figure)[\w\d*@]*" \
```

In the example above, the addition `|figure` instructs `latexdiff` to also
ignore the `figure` environment. This trick can be further extended to an
arbitrary number of environments (e.g., `sidewaysfigure`).

For a full overview of the capabilities of `latexdiff` make sure to check the
documentation by running `latexdiff --help`.

*Note.* To enable changes in `.bib` files please check [this
answer](https://tex.stackexchange.com/a/625721/134807).

## Release Notes

See the [CHANGELOG](CHANGELOG.md) file.

## Contributing

Any contributions, suggestions, or bug reports are welcome and greatly
appreciated.

## License

Foam is licensed under the [MIT license](LICENSE).
