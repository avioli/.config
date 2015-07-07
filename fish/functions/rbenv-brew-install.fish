function rbenv-brew-install -d "Installs rbenv if not installed"
  brew-install; and rbenv-check; or echo "Updating homebrew..."; and brew update; and brew install rbenv ruby-build --HEAD
end

