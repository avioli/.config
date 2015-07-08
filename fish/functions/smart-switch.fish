function smart-switch
  if test -z "$TMUX"
    tmux new -s $argv[1]
  else
    env TMUX= tmux new -d -s $argv[1]
    tmux switch -t $argv[1]
  end
end

