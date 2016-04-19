" Check and download plug.vim
if findfile('autoload/plug.vim', &rtp) ==# ''
  echo 'No vim-plug... installing'
  exec ':silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
" NOTE: Make sure you use single quotes
" NOTE: see ~/.vim/autoload/plug.vim for syntax

" NOTE: Add plugins to &runtimepath
call plug#end()
