function enc-sites
	openssl enc -aes256 -e -in $XDG_CONFIG_HOME/mpw/sites -out $XDG_CONFIG_HOME/mpw/sites.aes256
end
