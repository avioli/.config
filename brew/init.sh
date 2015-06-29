#!/usr/bin/env bash

set -e

## install homebrew if not installed
hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }

DONT_ASK=
function install () {
	local SHOULD_INSTALL
	if ! hash "$1" 2>/dev/null; then
		SHOULD_INSTALL=1
		if [ -z "$DONT_ASK" ]; then
			read -p "Install $1? (Y/n/a) " SHOULD_INSTALL
			case "$SHOULD_INSTALL" in
				a|A) DONT_ASK=1; SHOULD_INSTALL=1
				;;
				n|N) SHOULD_INSTALL=0
				;;
				*) SHOULD_INSTALL=1
				;;
			esac
		fi
		[ "$SHOULD_INSTALL" -eq 1 ] && echo "Installing $1" && brew install "$1"
	fi
	return 0 # since we are using 'set -e'
}

## shell
install fish

## password generator
install mpw

## essentials
install tig
install task

## dev
install editorconfig
install node
install rbenv
install ruby-build

## convenience
install peco
install ranger
install jq
install tree

## optional
#install brew-cask
#install imagemagick
#install ffmpeg

