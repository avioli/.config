function rbenv-check-notice -d "Checks for rbenv and prints a notice"
  # run with an argument to not check/show-the-notice more than once per session
  if test \( ! -f $TMPDIR/rbenv-checked \) -o \( (count $argv) -eq 0 \)
    if not rbenv-check
      touch $TMPDIR"rbenv-checked"
      set_color red; echo "No RBENV. To install: rbenv-install"; set_color normal
    else if test (count $argv) -eq 0
      echo "RBENV is installed"
    end
  end
end

