function tmux
  if hash tmux 2>/dev/null
    /usr/local/bin/tmux -f ~/.config/tmux/config.conf $argv
  else
    echo "No tmux. To install use:"
    set_color green; echo "tmux-brew-install"
    set_color normal
  end
end

