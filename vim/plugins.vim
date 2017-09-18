"""""""""""""""
""" Vim Plugins
"""""""""""""""

" Check and download plug.vim
if findfile('autoload/plug.vim', &rtp) ==# ''
  echo 'No vim-plug... installing'
  exec ':silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
" NOTE: Make sure you use single quotes
" NOTE: see ~/.vim/autoload/plug.vim for syntax

" Real-time auto completion
Plug 'Shougo/neocomplete'

" Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

" Syntastic (for syntax linting)
Plug 'scrooloose/syntastic'

" Class outline viewer
Plug 'majutsushi/tagbar'

" Go
Plug 'fatih/vim-go'

" Grepper
Plug 'mhinz/vim-grepper'

" Python autocompletion
Plug 'davidhalter/jedi-vim'

" Aligning up text
Plug 'godlygeek/tabular'

" NOTE: Add plugins to &runtimepath
call plug#end()

" NOTE: after loading a ton of plugins inspect startuptime via:
" vim --satrtuptime ~/.vim-startuptime ~/.vim-startuptime
