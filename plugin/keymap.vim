" Key mappings
" Last Change: 2021-10-19
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

nnoremap j gj
nnoremap k gk
nnoremap ZA :wqa<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
nnoremap <C-]> <C-]>zz

nnoremap `` ``zz
nnoremap n nzz
nnoremap N Nzz

nnoremap '+ "+
vnoremap '+ "+
nnoremap '= "=
vnoremap '= "=
nnoremap '0 "0
vnoremap '0 "0
inoremap <C-R>' <C-R>"
xmap q "

nnoremap <silent> <leader>ev :exec 'vsplit ' . general#vimfiles . '/init.vim'<CR>
nnoremap <silent> <leader>es :exec 'source ' . general#vimfiles . '/init.vim'<CR>
nnoremap <Leader>et :ToolEdit<CR>

noremap ]oq :cclose<CR>
noremap [oq :copen<CR>"}}}

noremap [op :setlocal paste<CR>
noremap ]op :setlocal nopaste<CR>
noremap yop :setlocal paste!<CR>"}}}


nnoremap <Leader>wo <C-w>o
nnoremap <Leader>wq <C-w>c
nnoremap <silent> <Leader>wjq :call <SID>close_window('j')<CR>
nnoremap <silent> <Leader>wkq :call <SID>close_window('k')<CR>
nnoremap <silent> <Leader>whq :call <SID>close_window('h')<CR>
nnoremap <silent> <Leader>wlq :call <SID>close_window('l')<CR>

nnoremap <leader>wh :hide<CR>
nnoremap <leader>wjh :call <SID>hide_window('j')<CR>
nnoremap <leader>wkh :call <SID>hide_window('k')<CR>
nnoremap <leader>whh :call <SID>hide_window('h')<CR>
nnoremap <leader>wlh :call <SID>hide_window('l')<CR>

nnoremap <Leader>wH <C-w>H
nnoremap <Leader>wJ <C-w>J
nnoremap <Leader>wL <C-w>L
nnoremap <Leader>wK <C-w>K

nnoremap <Leader>wv <C-w>v
nnoremap <Leader>ws <C-w>s
nnoremap <Leader>wt <C-w>T

nnoremap H <c-w>h
nnoremap L <c-w>l
nnoremap J <c-w>j
nnoremap K <c-w>k

nnoremap <Leader>w- <C-w>-
nnoremap <Leader>w= <C-w>+
nnoremap <leader>w, <C-w><
nnoremap <Leader>w. <C-w>>
tnoremap <M-q> <C-\><C-n>
nnoremap <silent> <M-m> :call tools#scroll_adjacent_window(1, 'n')<CR>
nnoremap <silent> <M-p> :call tools#scroll_adjacent_window(0, 'n')<CR>
inoremap <silent> <M-m> <ESC>:call tools#scroll_adjacent_window(1, 'i')<CR>
inoremap <silent> <M-p> <ESC>:call tools#scroll_adjacent_window(0, 'i')<CR>
nnoremap <silent> <M-u> :call tools#scroll_quickfix(0, 'n')<CR>
nnoremap <silent> <M-d> :call tools#scroll_quickfix(1, 'n')<CR>
inoremap <M-u> <silent> <ESC>:call tools#scroll_quickfix(0, 'i')<CR>
inoremap <M-d> <silent> <ESC>:call tools#scroll_quickfix(1, 'i')<CR>

nnoremap <leader>bd :bdelete<CR>
nnoremap <Leader><Tab> <C-^>

" switch to tab 1 ~ 9
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
" switch to the previous tab
nnoremap <leader>- gT
" switch to the next tab
nnoremap <leader>= gt
" close current tab
nnoremap <silent> <Leader>tq :tabclose<CR>
" save all buffers in current tab and close
nnoremap <silent> <Leader>ts :call <SID>close_tab_buffers()<CR>

nnoremap <silent> <leader>tt :NvimTreeToggle<CR>
nnoremap <silent> <leader>tr :NvimTreeRefresh<CR>
nnoremap <silent> <leader>tf :NvimTreeFindFile<CR>

function s:close_window(direction) abort
    let win_view = winsaveview()
    let win_id = win_getid()
    exec 'wincmd ' . a:direction
    wincmd c
    call win_gotoid(win_id)
    call winrestview(win_view)
endfunction

function s:hide_window(direction) abort
    let win_view = winsaveview()
    let win_id = win_getid()
    exec 'wincmd ' . a:direction
    hide
    call win_gotoid(win_id)
    call winrestview(win_view)
endfunction

function s:close_tab_buffers() abort
    let buf_name = bufname()
    let tab_buffers = tabpagebuflist()
    let old_lazyredraw = &lazyredraw
    try
        set lazyredraw
        for nr in tab_buffers
            execute 'buffer ' .. bufname(nr)
            update
        endfor
    finally
        let &lazyredraw = old_lazyredraw
        execute 'buffer ' .. buf_name
    endtry
    tabclose
endfunction
