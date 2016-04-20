"""""""""""""
" Neocomplete
"""""""""""""

" let g:neocomplete#enable_at_startup = 1

func NCE()
	NeoCompleteEnable
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	inoremap <expr><CR>   pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endfunction

