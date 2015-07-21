function find-upstream -d "Find a file in the current directory or traverse up to the root"
  # check for filename
  if not count $argv >/dev/null
    echo "No filename" >&2
    return 1
  end
  set -l name $argv[1]

  # check for path. default to pwd
  set -l path
  if test (count $argv) -ge 2
    # fragile... I know :)
    set path (pushd $argv[2]; and pwd; and popd)
  else
    set path (pwd)
  end

  if test -z "$path" -o "$path" = "/"
    #echo "Not found in "$path >&2
    return 1
  end

  if test -f $path/$name
    echo $path/$name
    return 0
  else
    #echo "Not found in "$path >&2
    if find-upstream $name (dirname $path)
      return 0
    else
      return 1
    end
  end
end

