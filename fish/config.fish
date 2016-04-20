# set explicit config path
set -gx XDG_CONFIG_HOME $HOME/.config
# set explicit data path
set -gx XDG_DATA_HOME $HOME/.local/share
# set explicit cache path
set -gx XDG_CACHE_HOME $HOME/.cache

# only run if tty is interactive and FISH_DONT_INIT isn't set
if test -t 0 -a -z "$FISH_DONT_INIT"

# set default editor
set -gx EDITOR vim

# add pear to path
set -gx PATH ~/pear/bin $PATH

# add android sdk tools to path
#set -gx PATH ~/android-sdk-macosx/platform-tools $PATH
set -gx PATH ~/Library/Android/sdk/platform-tools $PATH

# add go's root
set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# dasht docsets dir
set -gx DASHT_DOCSETS_DIR $XDG_CACHE_HOME

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

end
