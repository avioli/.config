function rbenv-check -d "Checks if there is an installed and initialised rbenv"
  not test \( ! -d /usr/local/var/rbenv \) -o \( ! -e /usr/local/bin/rbenv \)
end

