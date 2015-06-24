function cdf
  set -l dir (echo "tell application \"Finder\" to return POSIX path of (get first window's target as text)" | osascript ^/dev/null)

  if [ $status != 0 ]
    echo "Could not get the front-most Finder window" 1>&2
    return 1
  end

  cd "$dir"
  echo "$PWD"
  return 0
end
