function exit --description "Exit current session, but warn if within a TMUX session"
  status --is-interactive; or builtin exit $argv
  if set -q TMUX
    read -l -p "echo 'You are in TMUX session. Are you sure you want to exit or want to detach (Y/n/d) '" ASK
    switch (echo $ASK)
      case n N
        echo "OK"
      case d D
        detach
      case '*'
        builtin exit $argv
    end
  else
    builtin exit $argv
  end
end

