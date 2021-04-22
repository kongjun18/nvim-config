" Autocmd
" Last Change: 2021-04-22
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

augroup format
    autocmd BufWritePre * call <SID>remove_trailing_space()
    autocmd BufWritePre *.vim if &modified | :call <SID>update_timestamp() | endif
augroup END

autocmd BufWritePre * let &backupext = substitute(utils#up(utils#current_path()), g:general#delimiter, '~', 'g')

" Add git conflict maker to machit
autocmd BufReadPre * let b:match_words = '^<<<<<<<:^|||||||:^=======:^>>>>>>>'

autocmd VimEnter * call dein#call_hook('post_source')

augroup MyVimspectorUICustomistaion
  autocmd User VimspectorUICreated call <SID>vimspector_custom_ui()
augroup END

" Add convenient mappings and avoid mapping conflicts
autocmd DiffUpdated *
            \ if &diff |
            \     silent execute ':CocDisable'|
            \     nnoremap <buffer> <nowait> <silent> dp :diffput <SID>get_merged_file()<CR>|
            \     nnoremap <buffer> <nowait> <silent> gh :diffget //2<CR>]czz|
            \     nnoremap <buffer> <nowait> <silent> gl :diffget //3<CR>]czz|
            \     nnoremap <buffer> <nowait> <silent> [q :call <SID>handle_conflit_file('previous')<CR>|
            \     nnoremap <buffer> <nowait> <silent> ]q :call <SID>handle_conflit_file('next')<CR>|
            \ else |
            \     call <SID>local_unmap(['gh', 'gl', 'dp'])|
            \     silent execute ':CocEnable'|
            \ endif

" Jump to the previous/next conflicting file in quickfix without breaking
" Gvdiffsplit!
" param  direction  'previous' or 'next'
function s:handle_conflit_file(direction) abort
    if &modified
        echohl ErrorMsg | echo "Error: No write since last change, please save buffer." | echohl None
        return
    endif
    try
        execute 'c' .. a:direction
    catch /^Vim(\(cprevious\|cnext\)):E\d\+:/ " E553: No More Items
        echohl ErrorMsg | echo "Error: No More Items" | echohl None
        return
    endtry
    let l:local_bufnr = bufnr('//2')
    let l:target_bufnr = bufnr('//3')
    if l:local_bufnr > 0
        execute 'bdelete! ' .. l:local_bufnr
    endif
    if l:target_bufnr > 0
        execute 'bdelete! ' .. l:target_bufnr
    endif
    Gvdiffsplit!
    normal gg
endfunction

" Unmap buffer mapping
" param  mappings  a list of mapping or a single mapping
function s:local_unmap(mappings)
    if type(a:mappings) == v:t_list
        for l:mapping in a:mappings
            if !empty(maparg(l:mapping))
                execute 'unmap <buffer> ' .. l:mapping
            endif
        endfor
    elseif type(a:mappings) == v:t_string
        if !empty(maparg(l:mapping))
            execute 'unmap <buffer> ' .. a:mappings
        endif
    endif
endfunction

" Get buffer name of merged file in vim-fugitive's 3 way diff
function s:get_merged_file()
    let l:name = bufname('//2')
    if !empty(l:name)
        return matchstr(l:name, '//2/\zs\f\+\ze')
    endif
    let l:name = bufname('//3')
    if !empty(l:name)
        return matchstr(l:name, '//2/\zs\f\+\ze')
    endif
    return l:name
endfunction

" Update timestamp Last Change: YEAR-MONTH-DAY in copyright notice
function s:update_timestamp()
    let l:save_window = winsaveview()
    normal gg
    try
        let l:author_is_kongjun = search('^" Author: Kong Jun <kongjun18@outlook.com>', 'n', 10)
        if l:author_is_kongjun && !search('^" Last Change: ' .. strftime("%Y-%m-%d"))
            silent execute '1, 10s/^" Last Change:\s\+\zs\d\+-\d\+-\d\+\s*$/' .. strftime("%Y-%m-%d")
        endif
    catch //
        call winrestview(l:save_window)
        return
    endtry
    call winrestview(l:save_window)
endfunction

function s:remove_trailing_space() abort
    if &modified && &ft !~? '.*git.*'
        let l:cursor = getcurpos()
        :keepmarks %s/\s\+$//ge
        call setpos('.', l:cursor)
    endif
endfunction

" Custom Vimspector UI
" close console window to maximise source code window
function s:vimspector_custom_ui()
    call win_gotoid(g:vimspector_session_windows.output)
    :quit
    call win_gotoid(g:vimspector_session_windows.code)
    call setwinvar(g:vimspector_session_windows.variables, '&wrap', v:true)
    call setwinvar(g:vimspector_session_windows.watches, '&wrap', v:true)
    call setwinvar(g:vimspector_session_windows.stack_trace, '&wrap', v:true)
endfunction

