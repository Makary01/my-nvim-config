#!/usr/bin/env bash

set -euo pipefail

echo "Starting system setup..."

#################################
# install base dependencies
#################################

echo "Installing system dependencies..."
sudo apt update
sudo apt install build-essential procps curl file git default-jre -y
echo "System dependencies installed."

#################################
# install Homebrew
#################################

BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"

if [ ! -x "$BREW_BIN" ]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#################################
# load brew into this shell
#################################

eval "$($BREW_BIN shellenv)"

#################################
# ensure brew loads in future shells
#################################

if ! grep -q "linuxbrew" ~/.bashrc; then
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
fi

#################################
# update brew
#################################

echo "Updating Homebrew..."
brew update

#################################
# install brew packages
#################################

echo "Installing brew packages..."

brew bundle install

echo "Brew bundle installed."

echo "Setup completed succesfully!"

