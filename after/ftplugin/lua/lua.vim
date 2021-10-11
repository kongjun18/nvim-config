" Configuration for Lua
" Last Change: 2021-10-11
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0
" Only use coc.nvim as linter
let b:ale_linters = []
" Use 2 space indent for Lua
setlocal tabstop=2
setlocal shiftwidth=2
setlocal errorformat=%*\\f:\ %#%f:%l:\ %m
