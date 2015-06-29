# add pear to path
set -gx PATH ~/pear/bin $PATH

# add android sdk tools to path
set -gx PATH ~/android-sdk-macosx/platform-tools $PATH

# init rbenv
#rbenv-init

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

# STARTUP
#########
# check rbenv
#rbenv-check-notice once

# list tasks
tasks-remind

