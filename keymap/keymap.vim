" Basic mapping
" Last Change: 2020-11-28
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

map j gj
map k gk
map <C-f> <C-f>zz
map <C-b> <C-b>zz
map <C-d> <C-d>zz
map <C-u> <C-u>zz
map <C-o> <C-o>zz
map <C-i> <C-i>zz

if g:is_unix
	nnoremap <leader>ev :vsplit $HOME/.vimrc<CR>
	nnoremap <leader>es :source $HOME/.vimrc<CR>
    command ToolEdit :vsp ~/.config/nvim/autoload/tools.vim
else
	nnoremap <leader>ev :vsplit $HOME/_vimrc<CR>
	nnoremap <leader>es :source $HOME/_vimrc<CR>
    command ToolEdit :vsp ~/vimfiles/autoload/tools.vim
endif

nnoremap <Leader>et :ToolEdit<CR>

