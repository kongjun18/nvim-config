" Configuration of vimwiki
" Last Change: 2021-10-16
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

setlocal wrap           " Wrap line
setlocal spell          " Enable spell checking
setlocal shortmess+=c   " Suppress message of ins-complete-menu
setlocal cpt=.,k,w,b    " Source for dictionary, current buffer and other loaded buffers
" Enable <Tab> and <S-Tab> in vimwiki
imap <silent> <buffer> <expr> <tab>
		\ pumvisible()? "\<c-n>" :
		\ <SID>check_back_space() ? "\<tab>" : "\<c-n>"
imap <silent> <buffer> <expr> <s-tab>
		\ pumvisible()? "\<c-p>" : "\<s-tab>"
