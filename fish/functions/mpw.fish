function mpw -d "Extends mpw to store the sitename for later recall"
  # Extend mpw to store sitename in ~/.config/mpw/sites
  if [ -z $MPW_SITENAMES ]
    set MPW_SITENAMES ~/.config/mpw/sites
  end

  if [ -z $argv[1] ]
    set_color red
    echo "No sitename specified"
    set_color normal

    echo

    /usr/local/bin/mpw -h

    return 0
  end

  # run mpw
  /usr/local/bin/mpw $argv
  if test $status -ne 0
    return $status
  end

  set args (getopt u:t:c:V:v:C: $argv)
  set args (fish -c "for el in $args; echo \$el; end")

  # rule out the regular mpw arguments
  set i 1
  while true
    switch $args[$i]
      case "-u"
      case "-t"
      case "-c"
      case "-V"
      case "-v"
      case "-C"
      case "--"
        break
    end
    set i (math "$i + 1")
  end

  # get the site name
  set pargs
  if math "$i <" (count $args) > /dev/null
    set pargs $args[(math "$i + 1")..-1]
  end

  set error 0
  if test (count $pargs) -eq 0
    set error 1
  else if [ -z $pargs[1] ]
    set error 2
  end

  if not [ -w $MPW_SITENAMES ]
    set error 3
    set errormessage "$MPW_SITENAMES is not writable"
  end

  if test $error -gt 0
    set_color red
    if [ -z $errormessage ]
      echo "Unable to store sitename"
    else
      echo $errormessage
    end
    set_color normal
    return $error
  end

  # dedupe
  set found 0
  set sites (cat $MPW_SITENAMES)
  for s in $sites
    if test $s = $pargs[1]
      set found 1
      break
    end
  end

  # store sitename
  if test $found -eq 0
    echo $pargs[1] >> $MPW_SITENAMES
    echo "Stored" $pargs[1]
  end
end
