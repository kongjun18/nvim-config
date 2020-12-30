" Basic mapping
" Last Change: 2020-11-28
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

noremap j gj
noremap k gk
map <C-f> <C-f>zz
map <C-b> <C-b>zz
map <C-d> <C-d>zz
map <C-u> <C-u>zz
map <C-o> <C-o>zz
map <C-i> <C-i>zz

nnoremap <leader>ev :exec 'vsplit ' . g:vimfiles . '/init.vim'<CR>
nnoremap <leader>es :exec 'source ' . g:vimfiles . '/init.vim'<CR>
command ToolEdit :exec 'vsp ' . g:vimfiles . '/autoload/tools.vim'

nnoremap <Leader>et :ToolEdit<CR>

