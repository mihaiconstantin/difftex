# `difftex` - compare version-controlled `LaTeX` files

<div align="center">
    <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/mihaiconstantin/difftex">
    <img alt="Repository Status" src="https://img.shields.io/badge/repo%20status-WIP-yellow">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/mihaiconstantin/difftex">
</div>

<br>

`difftex` is a shell script wrapper around
[`latexdiff`](https://ctan.org/pkg/latexdiff?lang=en) to compare changes in
`.tex` files between two different `git` commits (e.g., to compare the changes
between `HEAD~1` and `HEAD`). It shares a similar purpose as [`Git
Latexdiff`](https://gitlab.com/git-latexdiff/git-latexdiff) but it is likely
narrower in scope.

## Installation

`difftex` can be installed by running:

```bash
curl https://raw.githubusercontent.com/mihaiconstantin/difftex/main/install.sh | sudo bash
```

The command above will perform the following steps:

1. Clone the `mihaiconstantin/difftex` repository into a temporary directory.
2. Copy `difftex.sh` to `/usr/local/bin/difftex`.
3. Adjust permissions and make `difftex` executable.

### Uninstalling

To uninstall the utility simply run:

```bash
sudo rm /usr/local/bin/difftex
```

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

## Release Notes

See the [CHANGELOG](CHANGELOG.md) file.

## Contributing

Any contributions, suggestions, or bug reports are welcome and greatly
appreciated.

## License

Foam is licensed under the [MIT license](LICENSE).
