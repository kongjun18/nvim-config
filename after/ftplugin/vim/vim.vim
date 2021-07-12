" VimL-specific setting
" Last Change: 2020-12-05
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0
setlocal foldmethod=marker

execute 'source' g:general#vimfiles .. g:general#delimiter .. 'after' .. g:general#delimiter .. 'ftplugin' .. g:general#delimiter .. 'common.vim'
