# Math Assignments and Presentations

![GitHub Workflow Status](https://github.com/robert-7/Math-Assignments-and-Presentations/actions/workflows/main.yaml/badge.svg)

Various papers and presentations done in LaTeX. Links to compiled PDFs can be found in the READMEs.

## Contributing

### Set up local linting

Linting is done with [`pre-commit`](https://pre-commit.com), a multi-language package manager for pre-commit hooks.

Follow the instructions at <https://pre-commit.com/#install> to install it, then run `pre-commit install` in the repo root to install the git hooks locally. They will run **automatically** every time you commit.

If you want to run all the checks manually, use `pre-commit run --all-files`. If you want to run just one of the checks, use `pre-commit run <hook_id>`.

All the hooks are also run automatically via CI when pushing, so installing them locally will save you from **realizing you made a mistake only after pushing**.

#### Installing ChkTeX

On Ubuntu, run this command:

```shell
sudo apt update
sudo apt install -y chktex shellcheck texlive-full
```
