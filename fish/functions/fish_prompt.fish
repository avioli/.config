function fish_prompt --description 'Write out the prompt'
        # Just calculate this once, to save a few cycles when displaying the prompt
        if not set -q __fish_prompt_hostname
                set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
        end

        # Determine PWD color and Suffix
        set -l color_cwd
        set -l suffix
        switch $USER
        case root toor
                if set -q fish_color_cwd_root
                        set color_cwd $fish_color_cwd_root
                else
                        set color_cwd $fish_color_cwd
                end
                set suffix '#'
        case '*'
                set color_cwd $fish_color_cwd
                set suffix '>'
        end

	# Define a separator
	set -l SEP '·'

        # TMUX
        if set -q TMUX
                echo -n 'T'
        else
                echo -n ' '
        end

        # Python virtualenv
        if set -q VIRTUAL_ENV
                echo -n -s $SEP (set_color normal) (set_color -o white) (basename $VIRTUAL_ENV) (set_color normal)
        end

        # User and hostname
        echo -n -s $SEP $USER @ $__fish_prompt_hostname

        # PWD
        echo -n -s $SEP (set_color $color_cwd) (prompt_pwd) (set_color normal)

        # GIT branch
        set -l GIT_BRANCH (git branch ^/dev/null | sed -n '/\* /s///p')
        echo -n -s $SEP $GIT_BRANCH

        # New line
        echo

        # Suffix
        echo -n -s $suffix ' '
end

