# Dotfiles

This repository contains my dotfiles. I use [GNU Stow](https://www.gnu.org/software/stow/) to manage them.

## Installation

Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Install GNU-Stow
```bash
brew install stow
```

Clone this repo
```bash
git clone git@github.com:josephburgess/dotfiles.git ~/
```

Restore dotfiles
```bash
cd ~/dotfiles
stow -t ~ *
```
Restore Brewfile
```bash
brew bundle install
```
