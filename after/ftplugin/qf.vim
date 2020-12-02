" Configuration of quickfix
" Last Change: 2020-11-28
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

setlocal nocursorline
nnoremap <buffer> <silent> q :wincmd q<CR>
noremap <silent><buffer> p :call quickui#tools#preview_quickfix()<cr>
