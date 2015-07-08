" symlink-to: ~/.vimrc
" vim: set fdm=marker :

" skip init for vim-tiny or vim-small
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    " be iMproved
    set nocompatible
  endif
endif

" Lots of VIM stuff have issues with FishShell, so we change it
if &shell =~# 'fish$'
  set shell=sh
endif

"======== EXTRA CONFIG {{{1
"=====================

if !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
  echo "No Vundle Plugin... "
  exec ':silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
endif

try
  source ~/.config/vim/vundle.vim
catch
  echohl "No Vundle config"
endtry

" disable encryption/decryption of buffers
" NOTE: this must never be set in a config
set key=

" enable per-directory .vimrc files
set exrc
" disable unsafe commands in local .vimrc files
set secure

" modelines
set modeline
set modelines=20

"}}}

"======== SEARCH {{{1
"=====================

" set the search scan to wrap lines
set wrapscan

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" show matching bracket
set showmatch

" set the forward slash to be the slash of note.
set shellslash

" set visual beel
set vb

" enable search highlighter
set hlsearch

" incrementally match the search
set incsearch

" hide search highlight if visible
:nohlsearch

"}}}

"======== NAVIGATION {{{1
"===================

" allow bacspace over indent, eol, and start of an insert
set backspace=2

" make the "cw" and like commands to put a $ at the end instead of just
" deleting the word
"set cpoptions=ces$
set cpoptions=B$

"}}}

"======== UI {{{1
"===========

" highlight current cursor line
" NOTE: it might drop responsiveness
set cursorline

" don't update display while executing macros
set lazyredraw

" hide the mouse when typing
set mousehide

" keep 8 lines from top and bottom when scrolling
set scrolloff=8

" wrap text to 200 columns
set textwidth=200

" highlight the 80th column
"set colorcolumn=80

" line numbers
set number
"set relativenumber
set numberwidth=5

"}}}

"======== INVISIBLES {{{1
"===================

" set non-printable characters
set listchars=nbsp:¬,tab:│\ ,extends:»,precedes:«,trail:•

"}}}

"======== COLOURS {{{1
"================

" set vi colors
if !exists(&t_Co)
  set t_Co=256
endif

" set default colour scheme
if &t_Co < 256 || $SSH_CLIENT || $SSH_CONNECTION
  set background=dark
  colorscheme default
elseif &t_Co >= 256 || has("gui_running")
  set background=dark
  try
    colorscheme xoria256
  catch
    colorscheme default
  endtry
endif

" turn syntax highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" systax coloring limited to 2048 chars
set synmaxcol=2048

"}}}

"======== BACKUPS {{{1
"================

" Store (or not) temporary files in a central spot
set nobackup          " do not keep backups after close
set nowritebackup     " do not keep a backup while working
set noswapfile        " don't keep swp files either
set backupcopy=yes    " keep attributes of the original file
set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,/private/tmp/*

"}}}

"======== BUFFERS {{{1
"================

" hide buffers, rather unloading, deleting or wiping them
set bufhidden=hide

" make sure unsaved buffers are allowed to go in background.
" no "must save first" error
set hidden

" switch buffers checks only the open buffers
set switchbuf=useopen

" automatically read changed open files
set autoread

"}}}

"======== STATUSLINE {{{1
"===================

" more useful statusline -- always on
set laststatus=2

" set the command line to two lines high
set cmdheight=2

"set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
"set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]
" TODO: add fugitive@statusline() when installed
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]\ %{strftime('%I:%M%p')}

" show the current mode
set showmode

"}}}

"======== COMMANDS {{{1
"=================

" keep more stuff in the history
set history=10000

" system default for mappings will be "," character
let mapleader = ","

" set timeout after chars for the "," commands
set timeoutlen=500

" better command line completion
set wildmenu
"set wildignorecase
" use emacs-style tab completion when selecting files, etc
"set wildmode=longest,list
" show a full list
"set wildmode=list:full
" set the key to advance in wildmenu
"set wildcharm=<C-z>

" auto completion search sequence and depth
set complete=.,w,b,t

" show the whole tag when completion is showing a function
set showfulltag

"}}}

"======== FOLDS {{{1
"==============

" set which commands open the folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" get rid of the silly characters in separators/folds
set fillchars = ""

"}}}

"======== DIFF & GREP {{{1
"====================

" ignore whitespace when diffing
set diffopt+=iwhite

" make grep work with single file
set grepprg=grep\ -nH\ $*

"}}}

"======== REGISTERS {{{1
"==================

" add the unnamed register to the clipboard
set clipboard+=unnamed

" enable/disable auto indentation (useful when yanking)
set pastetoggle=<F2>

"}}}

"======== AUTO CMDS {{{1
"==================

" custom autocmds
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " absolute line numbers in insert mode, then relative in normal/visual
  au InsertEnter * :set nu
  au InsertLeave * :set rnu
augroup END

"}}}

"======== TABS {{{1
"=============

set showtabline=2

"}}}

"======== FUNCTIONS {{{1
"==================

" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
command! RenameFile :call RenameFile()

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

" Extract variable
" Select something, press the keys and enter a var name. it will be inserted before the current row, assigned.
function! ExtractVariable(eqSign)
  let eqSign = " = "
  if exists(a:eqSign)
    eqSign = a:sqSign
  endif

  let name = input("Variable name: ")
  if name == ''
    return
  endif

  " Enter visual mode (not sure why this is needed since we're already in
  " visual mode anyway)
  normal! gv

  " Replace selected text with the variable name
  exec "normal c" . name
  " Define the variable on the line above
  exec "normal! O" . name . eqSign
  " Paste the original selected text to be the variable value
  normal! $p
endfunction

" Highlight characters over the 80 chars boundary
function! Mark80Col()
    match Error /\%81v.\+/
endfunction
command! Mark80Col :call Mark80Col()

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline
" in LaTeX files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ".
      \ "ts=%d sw=%d tw=%d :", &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

" Load any messages in the current/file path
function! ShowMessages()
  let fname = "messages"
  if(filereadable(fname))
    echohl WelcomeMsg
    echo "YOU'VE GOT MESSAGES:"

    for line in readfile(fname, '', 255)
      echo line
    endfor

    echo ""
    echohl None

    let choice = confirm('Remove messages?', "&No\n&Yes", 1)

    if(choice == 2)
      let delstatus = delete(fname)
      if (delstatus != 0)
        echohl WarnMsg
        echo "Failed to delete messages"
        echohl None
      endif
    else
      echohl WelcomeMsg
      echo "Messages retained"
      echohl None
    endif
  endif
endfunction
command! ShowMessages :call ShowMessages()

" Display the name of the function you are editing
fun FunctionName()
  let strList = ["while", "foreach", "ifelse", "if else", "for", "if", "else", "try", "catch", "case", "switch"]
  let foundcontrol = 1
  let position = ""
  let pos = getpos(".")          " This saves the cursor position
  let view = winsaveview()       " This saves the window view
  while (foundcontrol)
    let foundcontrol = 0
    normal [{
    call search('\S','bW')
    let tempchar = getline(".")[col(".") - 1]
    if (match(tempchar, ")") >=0 )
      normal %
      call search('\S','bW')
    endif
    let tempstring = getline(".")
    for item in strList
      if (match(tempstring,item) >= 0)
        let position = item . " - " . position
        let foundcontrol = 1
        break
      endif
    endfor
    if (foundcontrol == 0)
      call cursor(pos)
      call winrestview(view)
      return tempstring.position
    endif
  endwhile
  call cursor(pos)
  call winrestview(view)
  return tempstring.position
endfun

"}}}

"======== KEY BINDINGS {{{1
"=====================

" place the currently open file's path in the command line
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" move up and down by screen lines instead of text lines (normal mode)
nnoremap j gj
nnoremap k gk

" Y to yank to end of line (normal mode)
nmap Y y$

" turn off the highlight search (normal mode)
nmap <silent> ,n :nohlsearch<CR>
" clear the search buffer when hitting return (normal mode)
nnoremap <cr> :nohlsearch<cr>

" show invisible characters (normal mode)
nmap <silent> ,l :set list!<CR>

" window navigation
noremap <silent> <c-l> :wincmd l<CR>
noremap <silent> <c-k> :wincmd k<CR>
noremap <silent> <c-h> :wincmd h<CR>
noremap <silent> <c-j> :wincmd j<CR>

" buffers navigation
noremap <silent> ,bb :b#<CR>

" edit/view constrained in the currently open file's dir (expands above %%)
map ,e :edit %%
map ,v :view %%

" Ctrl-C acts as ESC (insert mode)
imap <c-c> <esc>

" highlight the word under the cursor and all its occurances
map ,hl *N

" tabs
nmap <c-1> :tabnext 1<cr>
nmap <c-2> :tabnext 2<cr>
nmap <c-3> :tabnext 3<cr>
nmap <c-4> :tabnext 4<cr>
nmap <c-5> :tabnext 5<cr>
"nmap <c-6> :tabnext 6<cr>
"nmap <c-7> :tabnext 7<cr>
"nmap <c-8> :tabnext 8<cr>
"nmap <c-9> :tabnext 9<cr>

" FUNCTIONS
" =========

" rename current file (saveas, followed by rm)
map ,rn :call RenameFile()<cr>

" indent if we're at the beginning of a line, else - do completion
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" extract variable - select something, invoke and enter a var name.
" it will be inserted before the current row, assigned.
vnoremap ,rv :call ExtractVariable(" = ")<cr>

" append modeline
nnoremap <silent> ,ml :call AppendModeline()<CR>

" this mapping assigns a variable to be the name of the function found by
" FunctionName() then echoes it back so it isn't erased if Vim shifts your
" location on screen returning to the line you started from in FunctionName()
map ,func :let name = FunctionName()<CR> :echo name<CR>

" EXTERNAL EXECUTABLES
" ====================

" sort
vnoremap ,ss !sort<cr>

"}}}

"======== Plugin config {{{1
"============================

" Vim-rooter
let g:rooter_manual_only = 1

" }}}

"======== ChompWhitespace {{{1
"============================

function! ChompWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
command! -nargs=0 ChompWhitespace call ChompWhitespace()

" }}}

"======== AT THE END OF VIMRC {{{1
"============================

call ShowMessages()

" }}}
