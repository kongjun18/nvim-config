" Language-specific configuration of gitcommit
" Last Change: 2021-10-16
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

setlocal wrap           " Wrap line
setlocal spell          " Enable spell checking
setlocal cpt=.,k,w,b    " Source for dictionary, current buffer and other loaded buffers
let b:EditorConfig_disable = 1 " Disable EditorConfig
iabbrev refector refactor
