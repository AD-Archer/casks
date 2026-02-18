# ad-archer/casks

Homebrew tap for casks published by AD-Archer.

## Install the tap

```bash
brew tap ad-archer/casks
```

## Install [RustySound](https://github.com/AD-Archer/RustySound)

```bash
brew install --cask rustysound
```

## Upgrade installed casks

```bash
brew update
brew upgrade --cask rustysound
```

## Available casks

- [`rustysound`](https://github.com/AD-Archer/RustySound)

## Automation

RustySound is auto-updated by GitHub Actions in `.github/workflows/update-rustysound-cask.yml`.

- Runs hourly (`:17` every hour)
- Supports manual run via `workflow_dispatch`
- Supports `repository_dispatch` event type `rustysound_release`
- Updates `Casks/rustysound.rb` version + sha256 and pushes commit only when changed
