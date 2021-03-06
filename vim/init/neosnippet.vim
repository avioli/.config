""""""""""""
" Neosnippet
"
" https://github.com/Shougo/neosnippet.vim
""""""""""""

" Plugin key-mappings.
" " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif
