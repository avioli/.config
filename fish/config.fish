# set default editor
set -gx EDITOR vim

# add pear to path
set -gx PATH ~/pear/bin $PATH

# add android sdk tools to path
set -gx PATH ~/android-sdk-macosx/platform-tools $PATH

# init rbenv
rbenv-init

# mpw
set -gx MP_FULLNAME "Evo Stamatov"
mpw-init

# setup tig's config file
set -gx TIGRC_USER ~/.config/tig/config

# task
set -gx TASKRC ~/.config/task/config
. ~/.config/task/local-config.fish

# Local bin
set -gx PATH ~/bin $PATH

# Gost cli gist generator
set -gx GOST (cat ~/.private/gost/token)

# Cheat
set -gx DEFAULT_CHEAT_DIR ~/.config/cheat
set -gx CHEATCOLORS=true

# STARTUP
#########
if test -n "$DONT_TMUX" -o -n "$TMUX"
  # check rbenv
  rbenv-check-notice once

  # list tasks
  tasks-remind
end

if test -z "$DONT_TMUX" -a -z "$TMUX"
  tmux attach; or play
end

