function dec-sites
	openssl enc -aes256 -d -in $XDG_CONFIG_HOME/mpw/sites.aes256
end
