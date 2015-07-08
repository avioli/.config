function detach
  set -q TMUX; and tmux detach; or echo "Not in a session"
end

