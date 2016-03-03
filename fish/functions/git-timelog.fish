function find-git
  if test -f git-dirs.txt
    # check if file is older than 30 minutes
    if test (find git-dirs.txt -mmin +60)
      echo "Gathering all newer .git repos within the current dir into git-dirs.txt..." >&2
      # not safe to append to the file, since we are comparing with its modification date
      find . -type d -name ".git" -newer git-dirs.txt -print | tee git-dirs-new.txt
      cat git-dirs.txt git-dirs-new.txt > git-dirs-tmp.txt; and mv git-dirs-tmp.txt git-dirs.txt; and rm git-dirs-new.txt
    end
  else
    echo "Gathering all .git repos within the current dir into git-dirs.txt..." >&2
    find . -type d -name ".git" -print | tee git-dirs.txt
    echo "Done" >&2
  end
  cat git-dirs.txt
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

    set -l logged (git --git-dir "$gitdir" log --date=iso --pretty=format:"%<(26)%ad%<(10,trunc)%cN %<(30)%aE %h %<(80,trunc)%s" -10 $argv 2> /dev/null)

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
