function brew-install -d "Installs homebrew if not installed"
  brew-check; or ruby -e (curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
end

