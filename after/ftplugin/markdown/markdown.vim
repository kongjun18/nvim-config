" Configuration of markdown
" Last Change: 2021-11-01
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

setlocal wrap           " Wrap line
setlocal spell          " Enable spell checking
setlocal cpt=.,k,w,b    " Source for dictionary, current buffer and other loaded buffers
execute 'setlocal dict=' . general#vimfiles .'/dict/word.dict'
