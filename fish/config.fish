# only run if tty is interactive and FISH_DONT_INIT isn't set
if test -t 0 -a -z "$FISH_DONT_INIT"

# set default editor
set -gx EDITOR vim

# add pear to path
set -gx PATH ~/pear/bin $PATH

# add android sdk tools to path
#set -gx PATH ~/android-sdk-macosx/platform-tools $PATH
set -gx PATH ~/Library/Android/sdk/platform-tools $PATH

# init rbenv
rbenv-init

# mpw
set -gx MP_FULLNAME "Evo Stamatov"
mpw-init

# setup tig's config file
set -gx TIGRC_USER ~/.config/tig/config

# task
set -gx TASKRC ~/.config/task/config
test -e ~/.config/task/local-config.fish; and . ~/.config/task/local-config.fish

# Local bin
set -gx PATH ~/bin $PATH

# Gost cli -- github gist generator
set -gx GOST (cat ~/.private/gost/token)

# Cheat
set -gx DEFAULT_CHEAT_DIR ~/.config/cheat
set -gx CHEATCOLORS=true

# haskell
# Add GHC 7.8.4 to the PATH, via http://ghcformacosx.github.io/
set -gx GHC_DOT_APP ~/Applications/ghc-7.8.4.app
if [ -d "$GHC_DOT_APP" ]
    set -gx PATH ~/.cabal/bin $GHC_DOT_APP/Contents/bin $PATH
end

# dep: brew install jump
status --is-interactive; and . (jump shell fish | psub)

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
  tmux attach; or play
end

test -e ~/.config/fish/config.local.fish; and . ~/.config/fish/config.local.fish

end
