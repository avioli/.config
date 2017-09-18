set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache

test -z "$CDPATH"; and set -x CDPATH .
set -x CDPATH $CDPATH $HOME/MyProjects $HOME/Projects $HOME/XCode $HOME/go/src/github.com/(whoami)

# silent kq_init warn in tmux
set -x EVENT_NOKQUEUE 1

# test if STDOUT is attached to TTY or a pipe - if so: exit
test -t 1 -o -p /dev/stdin; or exit

# set `pass` store location
set -x PASSWORD_STORE_DIR $XDG_CONFIG_HOME/password-store

# test if run within vim - if so: exit
test -z "$VIMRUNTIME"; or exit

# only run if tty is interactive and FISH_DONT_INIT isn't set
if test -t 0 -a -z "$FISH_DONT_INIT"

# use kak if available
if hash kak 2>/dev/null
  set -x EDITOR kak
else
  set -x EDITOR vim
end

# add rustc and cargo to path
set -x PATH $HOME/.cargo/bin $PATH

# add pear to path
set -x PATH ~/pear/bin $PATH

# add android sdk tools to path
#set -x PATH ~/android-sdk-macosx/platform-tools $PATH
#set -x PATH ~/Library/Android/sdk/platform-tools $PATH
test -z "$ANDROID_HOME" -a -e /usr/local/opt/android-sdk; and set -x ANDROID_HOME /usr/local/opt/android-sdk

# add racket to path
set -x PATH ~/Applications/Racket\ v6.4/bin $PATH

# add go's root
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# dasht docsets dir
set -x DASHT_DOCSETS_DIR $XDG_CACHE_HOME/dasht

# init rbenv
rbenv-init

# mpw
set -x MP_FULLNAME "Evo Stamatov"
mpw-init

# setup tig's config file
set -x TIGRC_USER $XDG_CONFIG_HOME/tig/config

# task
set -x TASKRC $XDG_CONFIG_HOME/task/config
test -e $XDG_CONFIG_HOME/task/local-config.fish; and . $XDG_CONFIG_HOME/task/local-config.fish

# Local bin
set -x PATH ~/bin $PATH

# Gost cli -- github gist generator
test -f ~/.private/gost/token; and set -x GOST (cat ~/.private/gost/token)

# Cheat
set -x DEFAULT_CHEAT_DIR $XDG_CONFIG_HOME/cheat
set -x CHEATCOLORS=true

# haskell
# Add GHC 7.8.4 to the PATH, via http://ghcformacosx.github.io/
set -x GHC_DOT_APP ~/Applications/ghc-7.8.4.app
if [ -d "$GHC_DOT_APP" ]
    set -x PATH ~/.cabal/bin $GHC_DOT_APP/Contents/bin $PATH
end

# dep: brew install jump
status --is-interactive; and . (jump shell fish | psub)

# disable virtualenv prompt hack
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# STARTUP
#########
if test -n "$TMUX"
  # only withing TMUX or in case DONT_TMUX is set
  # check rbenv
  rbenv-check-notice once

  # list tasks
  tasks-remind

  # virtualfish -- python virtualenv helper
  if set -l vf (python -m virtualfish)
    eval $vf
  end
else
  # attach TMUX
  if hash tmux 2>/dev/null
    tmux attach; or play
  else
    echo "No tmux"
  end
end

test -e $XDG_CONFIG_HOME/fish/config.local.fish; and . $XDG_CONFIG_HOME/fish/config.local.fish

# PHP composer
set -x PATH ~/.composer/vendor/bin $PATH

# yarn
set -x PATH ~/.yarn/bin $PATH

# fisherman
for file in ~/.config/fish/conf.d/*.fish
    source $file
end

end
