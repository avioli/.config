function git-timelog-me
  git-timelog -100 --author=Stam $argv
  echo "NOTE: use --since=YYYY-MM-DD --until=YYYY-MM-DD to bracket the results"
end

