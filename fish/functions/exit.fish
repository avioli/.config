function exit --description "Exit current session, but warn if within a TMUX session"
  if set -q TMUX
    read -l -p "echo 'You are in TMUX session. Are you sure you want to exit or want to detach (Y/n/d) '" ASK
    switch $ASK
      case n N
        echo "OK"
      case d D
        detach
      case '*'
        builtin exit
    end
  else
    builtin exit
  end
end

