function update-func-gitignore
	cd $XDG_CONFIG_HOME/fish/functions/; and find * -type l > .gitignore
end
