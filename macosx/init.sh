#!/usr/bin/env bash

set -e

if [ -f ./initialised ]; then
	exit
fi

# Disable accented characters when long-pressing a key
defaults write -g ApplePressAndHoldEnabled -bool false

touch ./initialised