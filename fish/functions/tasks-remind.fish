function tasks-remind --description "Lists tasks once every minute"
  set -l new_term_file "/tmp/.new-terminal-$USER"
  if not test -f "$new_term_file"
    task rc.verbose=blank,label,new-id,edit -url
    touch "$new_term_file"
  else
    set new_term_stat (stat -f "%m" "$new_term_file")
    if [ (math "$new_term_stat + 60") -lt (date +%s) ]
      task rc.verbose=blank,label,new-id,edit -url
      touch "$new_term_file"
    end
  end
end
