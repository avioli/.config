function tmux-brew-install -d "Installs tmux if not installed"
  brew-install; and rbenv-check; or echo "Updating homebrew..."; and brew update; and brew install tmux
end

