" Mapping about window
" Last Change: 2020-11-28
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

nnoremap <Leader>wt <C-w>T<CR>  " 将当前窗口移动为 tab

nnoremap <Leader>wo <C-w>o  " 仅保留当前窗口，关闭其他窗口
nnoremap <Leader>wc <C-w>c  " 关闭当前窗口
nnoremap <Leader>wq <C-w>c  " close current window
nnoremap <Leader>wjc <C-w>j<C-w>c<CR>kh " 关闭下面的窗口
nnoremap <Leader>wkc <C-w>k<C-w>c<CR>
nnoremap <Leader>whc <C-w>h<C-w>c<CR>kh
nnoremap <Leader>wlc <C-w>l<C-w>c<CR>kh
nnoremap <Leader>wjq <C-w>j<C-w>c<CR>kh " 关闭下面的窗口
nnoremap <Leader>wkq <C-w>k<C-w>c<CR>
nnoremap <Leader>whq <C-w>h<C-w>c<CR>kh
nnoremap <Leader>wlq <C-w>l<C-w>c<CR>kh

nnoremap <leader>wh :hide<CR>   " 隐藏当前窗口
nnoremap <leader>wjh <C-w>j:hide<CR>3h
nnoremap <leader>wkh <C-w>k:hide<CR>3h
nnoremap <leader>whh <C-w>h:hide<CR>3h
nnoremap <leader>wlh <C-w>l:hide<CR>3h

nnoremap <Leader>wH <C-w>H      " 将当前窗口移动到左边
nnoremap <Leader>wJ <C-w>J
nnoremap <Leader>wL <C-w>L
nnoremap <Leader>wK <C-w>K

nnoremap <Leader>wv <C-w>v      " split current window
nnoremap <Leader>ws <C-w>s      " vertical split current window

nnoremap H <c-w>h
nnoremap L <c-w>l
nnoremap J <c-w>j
nnoremap K <c-w>k

nnoremap <Leader>w- <C-w>-             " decrease current window height
nnoremap <Leader>w+ <C-w>+            " increase current window height
nnoremap <leader>w, <C-w><            " decrease current window widen
nnoremap <Leader>w. <C-w>>             " increase current window widen
tnoremap <M-q> <C-\><C-n>       " 内置终端切换为 normal 模式
nnoremap <M-m> :call tools#scroll_adjacent_window(1, 'n')<CR>
nnoremap <M-p> :call tools#scroll_adjacent_window(0, 'n')<CR>
inoremap <M-m> <ESC>:call tools#scroll_adjacent_window(1, 'i')<CR>
inoremap <M-p> <ESC>:call tools#scroll_adjacent_window(0, 'i')<CR>
nnoremap <M-u> :call tools#scroll_quickfix(0, 'n')<CR>
nnoremap <M-d> :call tools#scroll_quickfix(1, 'n')<CR>
inoremap <M-u> <ESC>:call tools#scroll_quickfix(0, 'i')<CR>
inoremap <M-d> <ESC>:call tools#scroll_quickfix(1, 'i')<CR>

nnoremap <leader>bd :bdelete<CR>
nnoremap <Leader><Tab> <C-^>

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>- gT
nnoremap <leader>= gt
