"""""""""""
" Syntastic
" Syntax linting
"
" https://github.com/vim-syntastic/syntastic#3-recommended-settings
"""""""""""

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Example: let g:syntastic_<filetype>_checkers = ['<checker-name>']
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
" let g:syntastic_python_checkers = ['pylint']

" Javascript
let g:syntastic_javascript_checkers = ['standard']
if filereadable($HOME . '/bin/npm-exec-standard')
	let g:syntastic_javascript_standard_exec = $HOME . '/bin/npm-exec-standard'
endif
"let g:syntastic_javascript_standard_generic = 1

" Sometimes when using both vim-go and syntastic Vim will start lagging while
" saving and opening files. The following fixes this:
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Another issue with vim-go and syntastic is that the location list window
" that contains the output of commands such as :GoBuild and :GoTest might not
" appear. To resolve this:
let g:go_list_type = "quickfix"
