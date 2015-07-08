function play
  test -z "$TMUX"; and tmux attach -t play; or tmux new -s play; or tmux switch -t play; or smart-switch play;
end

