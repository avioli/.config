function vagrant-tail-log -d "Run vagrant ssh -c 'tail -f /var/log/apache2/HOSTNAME_error.log'"
  set -l FQDNAME

  if count $argv >/dev/null
    set FQDNAME $argv[1]
  else
    set -l PARAMS_FILE (find-upstream parameters.sh)
    if test $status -eq 1
      echo "parameters.sh is not found" >&2
      return 1
    end

    set -l PARAMS (bash -c 'source "'$PARAMS_FILE'" 2>/dev/null && echo $WEBSITE_NAME && echo $TLD')
    test -z $PARAMS[2]; and set PARAMS[2] localhost
    set FQDNAME $PARAMS[1]"."$PARAMS[2]
  end

  vagrant ssh -c 'tail -f /var/log/apache2/'$FQDNAME'_error.log'
end

