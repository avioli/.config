function fish_prompt --description 'Write out the prompt'
        # Just calculate this once, to save a few cycles when displaying the prompt
        if not set -q __fish_prompt_hostname
                set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
        end

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

        set -l git_branch (git branch ^/dev/null | sed -n '/\* /s///p')

        if set -q VIRTUAL_ENV
                echo -n -s (set_color normal) '(' (set_color -o white) (basename $VIRTUAL_ENV) (set_color normal) ')' ' '
        end

        echo -n -s $USER @ $__fish_prompt_hostname ' '
        echo -n -s (set_color $color_cwd) (prompt_pwd) (set_color normal)
        echo -n -s '[' $git_branch ']'
        echo -n -s $suffix ' '
end

