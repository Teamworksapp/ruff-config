# ruff-config

This repo exists to keep a common ruff configuration for all Python repos.

The ruff version is managed by the system rather than individual repos (via uvx, using the latest ruff version, in
pre-commit hooks and whatever the developer installs for other runs of ruff).

When ruff.toml or the pre-commit ruff commands need to be changed, this is the one place to change it.

## Setup

The directory these steps are run in does not matter.

* `brew install uv`
* `pip install pre-commit`
  * Run this command for the system pip.
  * No Python virtual environment can be activated when running this command. Make sure the current directory is not
    within any code repo that auto-activates a virtual environment, or deactivate the environment first.
* `curl -o "$HOME/.ruff.toml" "https://raw.githubusercontent.com/Teamworksapp/ruff-config/refs/heads/main/ruff.toml"`
* `curl -o "$HOME/.ruff.sh" "https://raw.githubusercontent.com/Teamworksapp/ruff-config/refs/heads/main/ruff.sh"`
* `chmod +x "$HOME/.ruff.sh"`
  
## How It All Works

* The latest ruff.toml file lives in this repo.
* pre-commit hooks validate the latest ruff.toml file and latest ruff package is always used.

## How to Use Ruff in VSCode

* Add the following to `.vscode/settings.json` in the repo:

    ```json
    "[python]": {
        "editor.codeActionsOnSave": {
            "source.organizeImports": "explicit"
        },
        "editor.defaultFormatter": "charliermarsh.ruff"
    },
    ```

## Updating a Python Repo to Use This

* Copy `.pre-commit-config-template.yaml` as `pre-commit-config.yaml` in the repo
  * Replace the Python version with the version being used in the repo.
* In `pyproject.toml`...
  * Do not install the ruff package
  * Add the following settings, and all other ruff settings should be removed (and placed in the shared `ruff.toml` file in this repo if needed)

    ```toml
    [tool.ruff]
    extend = "${HOME}/.ruff.toml"
    target-version = "py39"
    ```

  * If something ruff-related absolutely MUST be project-specific, keep it in pyproject.toml.

## Updating this Repo

* Be very careful - any error in ruff.toml affects every single commit in repos that use this shared configuration.
* If the pre-commit hook needs to change, a change must be made in every repo. If ruff-pre-commit-config.yaml needs to
  change, it only has to change in this repo.
* If ruff.toml needs to change, simply update the file in this repo and once merged to the main branch, every commit
  made in repos that depend on it will take effect immediately.
