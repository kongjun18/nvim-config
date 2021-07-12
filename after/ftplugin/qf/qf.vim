" Configuration of quickfix
" Last Change: 2021-04-22
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

setlocal nocursorline
setlocal relativenumber
setlocal wrap
nnoremap <buffer> <silent> q :wincmd q<CR>
noremap <silent><buffer> p :call quickui#tools#preview_quickfix()<cr>
