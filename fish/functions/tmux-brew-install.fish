function tmux-brew-install -d "Installs tmux if not installed"
  brew-install; and brew update; and brew install tmux
end

