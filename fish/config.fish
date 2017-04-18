# set explicit config path
set -gx XDG_CONFIG_HOME $HOME/.config
# set explicit data path
set -gx XDG_DATA_HOME $HOME/.local/share
# set explicit cache path
set -gx XDG_CACHE_HOME $HOME/.cache

# make my life a bit simpler
test -z "$CDPATH"; and set -gx CDPATH .
set -gx CDPATH $CDPATH $HOME/Projects $HOME/XCode

# silent kq_init warn in tmux
set -gx EVENT_NOKQUEUE 1

# test if STDOUT is attached to TTY or a pipe - if so: exit
test -t 1 -o -p /dev/stdin; or exit

# set `pass` store location
set -gx PASSWORD_STORE_DIR $XDG_CONFIG_HOME/password-store

# test if run within vim - if so: exit
test -z "$VIMRUNTIME"; or exit

# only run if tty is interactive and FISH_DONT_INIT isn't set
if test -t 0 -a -z "$FISH_DONT_INIT"

# use kak if available
if hash kak 2>/dev/null
  set -gx EDITOR kak
else
  set -gx EDITOR vim
end

# add rustc and cargo to path
set -gx PATH $HOME/.cargo/bin $PATH

# add pear to path
set -gx PATH ~/pear/bin $PATH

# add android sdk tools to path
#set -gx PATH ~/android-sdk-macosx/platform-tools $PATH
#set -gx PATH ~/Library/Android/sdk/platform-tools $PATH
test -z "$ANDROID_HOME" -a -e /usr/local/opt/android-sdk; and set -gx ANDROID_HOME /usr/local/opt/android-sdk

# add racket to path
set -gx PATH ~/Applications/Racket\ v6.4/bin $PATH

# add go's root
set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# dasht docsets dir
set -gx DASHT_DOCSETS_DIR $XDG_CACHE_HOME/dasht

# init rbenv
rbenv-init

# mpw
set -gx MP_FULLNAME "Evo Stamatov"
mpw-init

# setup tig's config file
set -gx TIGRC_USER $XDG_CONFIG_HOME/tig/config

# task
set -gx TASKRC $XDG_CONFIG_HOME/task/config
test -e $XDG_CONFIG_HOME/task/local-config.fish; and . $XDG_CONFIG_HOME/task/local-config.fish

# Local bin
set -gx PATH ~/bin $PATH

# Gost cli -- github gist generator
test -f ~/.private/gost/token; and set -gx GOST (cat ~/.private/gost/token)

# Cheat
set -gx DEFAULT_CHEAT_DIR $XDG_CONFIG_HOME/cheat
set -gx CHEATCOLORS=true

# haskell
# Add GHC 7.8.4 to the PATH, via http://ghcformacosx.github.io/
set -gx GHC_DOT_APP ~/Applications/ghc-7.8.4.app
if [ -d "$GHC_DOT_APP" ]
    set -gx PATH ~/.cabal/bin $GHC_DOT_APP/Contents/bin $PATH
end

# dep: brew install jump
status --is-interactive; and . (jump shell fish | psub)

# disable virtualenv prompt hack
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

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
set -gx PATH ~/.composer/vendor/bin $PATH

# yarn
set -gx PATH ~/.yarn/bin $PATH

# fisherman
for file in ~/.config/fish/conf.d/*.fish
    source $file
end

end
