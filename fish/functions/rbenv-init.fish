function rbenv-init -d "Initialises rbenv defaults"
  # check for rbenv var dir
  if test \( -d /usr/local/var/rbenv \) -a \( -e /usr/local/bin/rbenv \)
    set -x RBENV_ROOT /usr/local/var/rbenv
    . (rbenv init -|psub)
  # check for rbenv binary
  else if test -e /usr/local/bin/rbenv
    set_color red; echo "RBENV is not initialised. Initialising..."; set_color normal
    set -x RBENV_ROOT /usr/local/var/rbenv
    . (rbenv init -|psub)
  end
end

