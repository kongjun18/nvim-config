" Configuration of GVim
" Last Change: 2021-01-13
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0
if exists('loaded_gvimrc') || &cp || version < 700
    finish
endif
let loaded_gvimrc = 1

set t_vb= " No beep

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
if general#is_unix
    set guifont=Source\ Code\ Pro\ 9
else
    set guifont=Source_Code_Pro:h12:cANSI:qDRAFT
endif
" Enable direct2d render
set renderoptions=type:directx,renmode:5,taamode:1
