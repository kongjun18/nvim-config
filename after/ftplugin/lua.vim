" Configuration of Lua
" Last Change: 2020-11-11
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

execute 'source' g:general#vimfiles .. g:general#delimiter .. 'after' .. g:general#delimiter .. 'ftplugin' .. g:general#delimiter .. 'common.vim'

setlocal tabstop=2
setlocal shiftwidth=2
setlocal efm=%E%.%#\ %f:%l:\ %m
