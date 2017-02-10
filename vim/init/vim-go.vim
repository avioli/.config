""""""""
" Vim-go
"
" https://github.com/fatih/vim-go#example-mappings
""""""""

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" Open the target identifier in current buffer
au FileType go nmap <leader>ds <Plug>(go-def-split)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)
au FileType go nmap <leader>dt <Plug>(go-def-tab)

" Open the relevant Godoc for the word under the cursor
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)

" Open the Godoc in browser
au FileType go nmap <leader>gb <Plug>(go-doc-browser)

" Show a list of interfaces which is implemented by the type under your cursor
au FileType go nmap <leader>s <Plug>(go-implements)

" Show type info for the word under your cursor
" (if g:go_auto_type_info is disabled)
au FileType go nmap <leader>i <Plug>(go-info)

" Rename the identifier under the cursor to a new name
au FileType go nmap <leader>e <Plug>(go-rename)

" By default syntax-highlighting for Functions, Methods and Structs is
" disabled.
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "goimports"

" Disable auto fmt on save
" let g:go_fmt_autosave = 0
