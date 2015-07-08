function work
  test -z "$TMUX"; and tmux attach -t work; or tmux new -s work; or tmux switch -t work; or smart-switch work;
end

