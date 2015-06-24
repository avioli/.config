function find-git
  if test -f git-dirs.txt
    cat git-dirs.txt
  else
    echo "Gathering all .git repos within the current dir into git-dirs.txt..." >&2
    find . -type d -name ".git" -print | tee git-dirs.txt
    echo "Done" >&2
    cat git-dirs.txt
  end
end

function git-timelog --description "Go through all git repos within current dir and log. Uses -10. Use --since and --until to cap results."
  set -l pwd $PWD

  set -l columns ""
  for c in (seq $COLUMNS); set columns "$columns "; end

  find-git | while read dir
    set -l gitdir $dir

    set -l bn (basename "$dir")
    if [ "$bn" = ".git" ]
      set dir (dirname "$dir")
    end

    echo -n $dir\r >&2

    set -l logged (git --git-dir "$gitdir" log --date=short --pretty=format:"%<(12)%ad%<(10,trunc)%cN %<(30)%aE %h %<(80,trunc)%s" -10 $argv 2> /dev/null)

    if test -n "$logged"
      echo $dir
      for line in $logged
        echo $line
      end
    else
      echo -n $columns\r >&2
    end

  end

  echo "You can safely delete git-dirs.txt when done" >&2
end
