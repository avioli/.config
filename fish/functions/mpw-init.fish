function mpw-init -d "Initialises mpw defaults"
  # check if we've got the config dir
  if test -d ~/.config/mpw
    set -q MPW_SITENAMES; or set -gx MPW_SITENAMES ~/.config/mpw/sites

    if hash openssl 2>/dev/null
      if test ! -f "$MPW_SITENAMES" -a -f "$MPW_SITENAMES.aes256"
        echo "Found $MPW_SITENAMES.aes256. Would you like to decrypt it if you know the decryption password?"
        openssl enc -aes256 -d -in "$MPW_SITENAMES.aes256" -out "$MPW_SITENAMES"; or rm "$MPW_SITENAMES"
      end
    end

    test -f "$MPW_SITENAMES"; and complete -c mpw -x -a "(cat "$MPW_SITENAMES")"
  end
end

