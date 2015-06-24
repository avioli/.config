function brew-check -d "Checks if there is an installed homebrew"
  test \( -d /usr/local/Cellar \) -a \( -e /usr/local/bin/brew \)
end

