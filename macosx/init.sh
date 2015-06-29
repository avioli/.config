#!/usr/bin/env bash

set -e

if [ -f ./initialised ]; then
	exit
fi

# Disable accented characters when long-pressing a key
defaults write -g ApplePressAndHoldEnabled -bool false

# Keyboard repeat and retreat rates
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

touch ./initialised
