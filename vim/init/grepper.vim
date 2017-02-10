"""""""""
" Grepper
"
" https://github.com/mhinz/vim-grepper/wiki/example-configurations-and-mappings
"""""""""

nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool pt<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Optional. The default behaviour should work for most users.
" let g:grepper               = {}
" let g:grepper.tools         = ['git', 'ag', 'rg']
" let g:grepper.jump          = 1
" let g:grepper.next_tool     = '<leader>g'
" let g:grepper.simple_prompt = 1
" let g:grepper.quickfix      = 0

command! Todo :Grepper -tool git -query '\(TODO\|FIXME\)'
