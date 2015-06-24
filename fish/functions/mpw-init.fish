function mpw-init -d "Initialises mpw defaults"
  # check if we've got the config dir
  if test -d ~/.config/mpw
    set -gx MPW_SITENAMES ~/.config/mpw/sites
    complete -c mpw -x -a "(cat $MPW_SITENAMES)"
  end
end

