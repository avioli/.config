function ssha
  set -l ssharc ".ssharc"
  set -l ssha_dir "$PWD"

  while true
    if [ "$ssha_dir" = "" ]; break; end
    if [ "$ssha_dir" = "/" ]; break; end
    if test -f "$ssha_dir/$ssharc"; break; end
    set ssha_dir (dirname "$ssha_dir")
  end

  if not test -f "$ssha_dir/$ssharc"
    echo "No $ssharc file found."
    return 1
  end

  if [ "$ssha_dir" != "$PWD" ]; echo "Using $ssha_dir/$ssharc"; end

  set -l line
  set -l lines (cat "$ssha_dir/$ssharc")
  set -l count (count $lines)
  set -l selected 0
  set -l current 0

  if math "$count > 1" > /dev/null
    set current 1
    for line in $lines
      echo (set_color green)$current(set_color normal)">" $line
      set current (math "$current + 1")
    end
    read selected
  else
    set line (head -1 "$ssha_dir/$ssharc")
  end

  if test -n "$selected"
    if math "$selected > 0" > /dev/null
      if math "$selected < $current" > /dev/null
        set line $lines[$selected]
      end
    end
  end

  if test -n "$line"
    set -l host (echo "$line" | cut -f1 -d:)
    set -l dir (echo "$line" | cut -f2 -d:)

    echo "Logging in $host..."

    ssh "$host" -t 'cd "'$dir'"; bash --login'
  end

  # TODO: ssh should be executed parallel and function should close
end
