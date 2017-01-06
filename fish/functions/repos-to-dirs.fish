function repos-to-dirs --description 'walks current pwd and moves every repo to its own dir struct'
  if test (count $argv) -lt 1
    echo 'Walks current pwd and moves every git repo to its own dir struct. For use by ghq.'
    echo
    echo 'Essentially:'
    echo '  A dir xyz from remote repo git://github.com/avioli/xyz.git will go to'
    echo '  $output-path/github.com/avioli/xyz'
    echo 'Pseudo commands:'
    echo '  for every dir in current pwd'
    echo '    git remote get-url origin'
    echo '    mkdir (dirname $output-path/$remote-url | ... custom-stripped)'
    echo '    mv $dir $output-path/$remote-url-dir-struct'
    echo
    echo 'ERROR: You must specify output path'
    return
  end

  set -l OUT $argv[1]

  find . -type d -maxdepth 1 -not -path '.' | \
    while read dir
      set -l NEW_DIR (env GIT_DIR=$dir/.git git remote get-url origin 2>/dev/null | sed -e 's|\.git$||' -e 's|^git@||' -e 's|^https://||' -e 's|^git://||' | tr ':' '/')
      if test -n "$NEW_DIR"
        mkdir -p (dirname "$OUT/$NEW_DIR")
        echo "$dir => $OUT/$NEW_DIR"
        mv "$dir" "$OUT/$NEW_DIR"
      else
        echo "SKIPPING $dir -- no git remote found"
      end
    end
end
