" Autocmd
" Last Change: 2021-01-20
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

if exists('g:loaded_autocmd_vim') || &cp || version < 700
    finish
endif
let g:loaded_autocmd_vim = 1

augroup nerdtree
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " Avoid open wrong directory in NERDTree window
    autocmd BufWinEnter * if &ft != 'nerdtree'       |
            \ let t:last_accessed_winnr = winnr() |
            \ if !exists('t:nerdtree_open_mode')     |
            \     let t:nerdtree_open_mode = {
            \         'root': 0,
            \         'outermost': 0,
            \         'innermost': 0
            \     }                                  |
            \ endif                                  |
            \ endif
    autocmd BufWinLeave * if &ft == 'nerdtree'       |
            \ let t:nerdtree_open_mode = {
            \   'root': 0,
            \   'outermost': 0,
            \   'innermost': 0
            \ }                                      |
            \ endif
augroup END

augroup machit
    " Add git conflict maker to machit
    autocmd BufReadPre * let b:match_words = '^<<<<<<<.*$:^|||||||.*$:^=======.*$:^>>>>>>>.*$'
augroup END
