### XDG
#######

set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache

### TMUX
#########

if isatty
  if test "$TERM" != screen -a -z "$INSIDE_EMACS"
    if hash tmux 2>/dev/null
      if not tmux ls 2>/dev/null
        set -x SHELL_OLD $SHELL
        # set SHELL env to bash so reattach-to-user-namespace doesn't start fish twice
        exec env SHELL=/bin/bash tmux -f $XDG_CONFIG_HOME/tmux/config.conf new -s play
        exit
      else
        exec tmux attach
        exit
      end
    else
      set_color red
      echo "No tmux"
      set_color normal
    end
  end
end

if test -n "$SHELL_OLD"
  set -x SHELL $SHELL_OLD
end


### LOCALE
##########

set -x LC_ALL en_AU.utf-8
set -x LANG en_AU.utf-8


### PATHS
#########

set -x GOPATH $HOME/go

set -x CDPATH . $HOME/MyProjects $HOME/Projects $HOME/XCode $GOPATH/src/github.com/(whoami)

set -x PATH $GOPATH/bin $HOME/.cargo/bin $HOME/bin $PATH

### ANDROID DEV TOOLS
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x PATH $PATH $ANDROID_HOME/tools
set -x PATH $PATH $ANDROID_HOME/platform-tools

### CONFIGS
###########

# tig -- git tui
set -x TIGRC_USER $XDG_CONFIG_HOME/tig/config

# task -- cli task manager
set -x TASKRC $XDG_CONFIG_HOME/task/config

# cheat
set -x DEFAULT_CHEAT_DIR $XDG_CONFIG_HOME/cheat
set -x CHEATCOLORS true

# dasht
set -x DASHT_DOCSETS_DIR $XDG_CACHE_HOME/dasht

### EXIT EARLY
##############

# check if within vim
if set -q VIMRUNTIME
  exit
end

if not isatty
  exit
end

### INTERACTIVE TTY
###################

# disable virtualenv prompt hack
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# mpw
set -x MP_FULLNAME "Evo Stamatov"
mpw-init

# pass
set -x PASSWORD_STORE_DIR $XDG_CONFIG_HOME/password-store

# rbenv
rbenv-init

# jump -- brew install jump
if hash jump 2>/dev/null
  . (jump shell fish | psub)
end

# task
if test -r $XDG_CONFIG_HOME/task/local-config.fish
  . $XDG_CONFIG_HOME/task/local-config.fish
end

### LOCAL CONFIG
################

if test -r $XDG_CONFIG_HOME/fish/config.local.fish
  . $XDG_CONFIG_HOME/fish/config.local.fish
end

