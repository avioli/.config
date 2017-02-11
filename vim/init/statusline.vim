function! IsHls()
	return ''.(&hls?'H':'').''
endfunction

function! Enc()
	return ''.(&fenc!=''?&fenc:&enc).''
endfunction

set laststatus=2                     " always show statusline

set statusline=
set statusline +=%0*\                " white on black + padding
set statusline +=%n                  " buffer number
set statusline +=\ %{&ff}            " file format (dos/unix...)
set statusline +=%Y                  " file type
set statusline +=\ %{Enc()}          " encoding
"set statusline +=\ %{IsHls()}        " higlight search
"set statusline +=\ %{&spelllang}     " Spellanguage
set statusline +=\                   " end padding
set statusline +=%1*\                " black on white + padding
set statusline +=%<%F                " full path
set statusline +=%m                  " modified flag
set statusline +=%r                  " readonly flag
set statusline +=%h                  " help flag
set statusline +=%=                  " right align
set statusline +=%0*\                " white on black + padding
set statusline +=r:%5l               " current line num
set statusline +=/%L                 " num total lines
set statusline +=\ (%3p%%)           " current line pos %
set statusline +=\ c:%5c%V           " virtual column number
set statusline +=\ 0x%04B            " character under cursor
set statusline +=\ %P                " Top/Bot/All/%
set statusline +=\                   " end padding
