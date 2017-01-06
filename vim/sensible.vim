""""""""""""""""""""""""""""""
""" Some sensible VIM defaults
""""""""""""""""""""""""""""""

" NOTE: most of these are based on https://github.com/tpope/vim-sensible

" lots of VIM stuff have issues with FishShell, so we change it
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" enable loading of plugins and indent files for detected filetypes
if has('autocmd')
  filetype plugin indent on
endif

" enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
"if &t_Co > 2 || has("gui_running")
"  syntax on
"endif

" NOTE: use :help 'option' to see the documentation for the given option.

" disable encryption/decryption of buffers
" NOTE: this must never be set in a config
set key=

" enable sourcing per-directory .vimrc files
set exrc

" disable unsafe commands in local .vimrc files
set secure

" systax coloring limited to 255 chars
set synmaxcol=255

" enable auto indentation (adding spaces/tabs when inserting on a new line)
set autoindent

" allow backspace to remove indenatation, end-of-line and go past start-of-inserts
set backspace=indent,eol,start

" remove scanning of current and included files from the defaults
set complete-=i

" make tabbing to be smart about indents
set smarttab

" rid off the octal numbering for C-A and C-X
" (incrementing and decrementing numbers)
set nrformats-=octal

" set mappings/key-codes timeout
set ttimeout
set ttimeoutlen=100

" show search hits while typing the pattern
set incsearch
" use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" always show a status line
set laststatus=2

" show the line and column number of the cursor position (in the statis line)
set ruler

" use enhanced command-line completion (tabbing commands, files, etc)
set wildmenu

" set minimal screen lines above/below the cursor
if !&scrolloff
  set scrolloff=1
endif

" set minimal screen lines left/right the cursor
if !&sidescrolloff
  set sidescrolloff=5
endif

" show as much as possible of the last line in a window
set display+=lastline

" set encoding to utf-8
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" set invisible characters (visible while in 'set list' mode)
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" rid off some tags paths
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" reload edited file automatically (if not edited in vim)
set autoread

" set minimum history size
if &history < 1000
  set history=1000
endif

" set maximum tab pages to be opened from the command-line
if &tabpagemax < 50
  set tabpagemax=50
endif

" allow to save and restore global variables in all UPPERCASE
if !empty(&viminfo)
  set viminfo^=!
endif

" don't store options and mappings in the session
set sessionoptions-=options

" allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" make C-U (which deletes everything before the cursor) to start a new
" change, so you can undo that, if pressed by accident.
inoremap <C-U> <C-G>u<C-U>
" same deal as above, but for C-W (which deletes the word before the cursor)
inoremap <C-W> <C-G>u<C-W>

" read modelines (see last line of this very file)
set modeline

" vim:set ft=vim et sw=2:
