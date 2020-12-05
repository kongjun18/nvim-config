" Basic mapping
" Last Change: 2020-11-28
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

map j gj
map k gk
map <C-o> <C-o>zz
map <C-i> <C-i>zz

if has('win32')
	nnoremap <leader>ev :vsplit $HOME/_vimrc<CR>
	nnoremap <leader>es :source $HOME/_vimrc<CR>
elseif has('unix')
	nnoremap <leader>ev :vsplit $HOME/.vimrc<CR>
	nnoremap <leader>es :source $HOME/.vimrc<CR>
endif


command ToolEdit :vsp ~/.config/nvim/autoload/tools.vim
nnoremap <Leader>et :ToolEdit<CR>

