function math2 --description 'Perform math calculations in bc'
  if count $argv >  /dev/null
    set -l processing 0

    switch $argv[1]
      case -h --h --he --hel --help
        __fish_print_help math

        echo "======="
        echo
        echo "       math2 − Perform mathematics calculations using scoped awk"
        echo
        #set_color --bold normal
        echo "   Arguments"
        #set_color normal
        echo "       math2 -p EXPRESSION"
        echo "       Print what will be processed by awk"
        echo
        #set_color --bold normal
        echo "   Output"
        #set_color normal
        echo "       math2 -p \"3/4\" 2> /dev/null"
        echo
        echo "       strips the output of \"Processing: ...\", which goes to STDERR."
        return 0
      case -p --processing
        set processing 1
        set argv $argv[2..-1]
    end

    set -l args (echo $argv | sed "s/[^0-9.+-\*\/^%]//g")
    if test $processing -eq 1
      echo "Processing: $args" >&2
    end

    set -l out (awk "BEGIN {print $args}")
    test -z "$out"; and return 1
    echo $out
    switch $out
      case 0
        return 1
    end
    return 0
  end
  return 2
end
