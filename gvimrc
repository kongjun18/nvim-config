" Configuration of GVim(Windows)
" Last Change: 2020-12-28
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

set t_vb= " No beep

" Use the Documents as default working directory
source ~/vimfiles/init.vim
if g:is_windows
	autocmd VimEnter * cd "$HOME\Documents"
endif

" Fullscreen
autocmd GUIEnter * simalt ~x

" Delete tool bar, menu bar and scroll bar
set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=R
set guioptions-=r
set guioptions-=l

" Use Source Code Pro as default font 
set guifont=Source_Code_Pro:h12:cANSI:qDRAFT

