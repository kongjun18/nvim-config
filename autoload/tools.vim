" Some tools for Vim
" Last Change: 2021-03-17
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

" guard
if exists('g:loaded_tools_vim') || &cp || version < 700
    finish
endif
let g:loaded_tools_vim = 1

" create_gitignore() -- Create gitignore template
" @brief: Create .gitignore file for C/C++
" @note:     only impletemt c and cpp
function tools#create_gitignore(filetype)
    if filereadable('.gitignore')
        echomsg "This project had .gitignore"
        return
    endif

    if a:filetype == 'c' ||  a:filetype == 'cpp'
        try
            call utils#copy(g:general#vimfiles .. g:general#delimiter .. 'tools' .. g:general#delimiter .. 'gitignore' .. g:general#delimiter .. 'c_gitignore', utils#get_root_dir(utils#current_path()))
        catch *
            echomsg "Error in tools#create_gitignore()"
        endtry
    else
        echomsg "This type don't impletemted"
    endif
endfunction

function tools#create_vimspector(path)
    call utils#copy(g:general#vimfiles .. g:general#delimiter .. 'tools' .. g:general#delimiter .. '.vimspector.json', a:path)
endfunction

" Delete gtags generated by gutentags of a:project_dir
" depends asyncrun and gutentags
" If gtags encounters errors, call this function to delete gtags generated by
" gutentags and run :GutentagsUpdate
"
" For example, :call tools#rm_tags(asyncun#get_root('%'))
function g:tools#rm_gtags(project_dir)
    let l:gtags_dir = a:project_dir
    if l:gtags_dir[0] != '~' && l:gtags_dir[0] != '/'
        echoerr "tools#rm_tags: argument error"
    endif
    if l:gtags_dir[0] == '~'
        let l:gtags_dir = substitute(l:gtags_dir, '~', "$HOME")
    endif
    let l:gtags_dir = substitute(l:gtags_dir, '\/', '-', 'g')
    let l:gtags_dir = substitute(l:gtags_dir, '^-', '\/', '')
    let l:gtags_dir = trim(l:gtags_dir)
    let l:gtags_dir = printf("%s%s", g:gutentags_cache_dir, l:gtags_dir)
    if delete(l:gtags_dir, 'rf') != 0
        echoerr "Can't delete tag directory " . l:gtags_dir
    endif
endfunction
"

" scroll_adjacent_window() -- Scroll adjcent window without change focus
" @para dir  0 -- up  1 -- down
" @para mode 'i' -- insert 'n' -- normal
" @complain neovim don't support win_execute(). What a pity!!!
function tools#scroll_adjacent_window(dir, mode)
    function! s:switch_to_insert(old_cursor, tail_cursor) abort
        if a:old_cursor == a:tail_cursor - 1
            noautocmd wincmd p
            startinsert!
        else
            noautocmd wincmd p
            exec 'normal l'
            noautocmd wincmd p
            startinsert
            noautocmd wincmd p
        endif
    endfunction

    let left_winnr = winnr('h')
    let right_winnr = winnr('l')
    let cur_winnr = winnr()
    let old_cursor = col(".")
    let tail_cursor = col("$")
    if left_winnr <= 0 && right_winnr <= 0
        echomsg "Unknown error in tools#scroll_adjacent_window()"
        if a:mode == 'i'
            call s:switch_to_insert(old_cursor, tail_cursor)
        endif
        return
    endif

    " only one window?
    if left_winnr == right_winnr
        echomsg "Only a single window"
        if a:mode == 'i'
            call s:switch_to_insert(old_cursor, tail_cursor)
        endif
        return
    endif

    let win_num = tabpagewinnr(tabpagenr(), '$')
    if  win_num != 2 && !(win_num == 3 && getqflist({'winid': 0}).winid != 0)
        echomsg "More than two adjcent windows"
        if a:mode == 'i'
            call s:switch_to_insert(old_cursor, tail_cursor)
        endif
        return
    endif

    let go_direction = 'h'
    let back_direction = 'l'
    if right_winnr != cur_winnr
        let go_direction = 'l'
        let back_direction = 'h'
    endif

    noautocmd silent! wincmd p
    if a:dir == 0
        exec "normal! \<ESC>\<C-W>" . go_direction . "\<C-U>\<C_W>" . back_direction
    elseif a:dir == 1
        exec "normal! \<ESC>\<C-W>" . go_direction . "\<C-D>\<C_W>" . back_direction
    endif
    " scroll in insert mode?
    if a:mode == 'i'
        call s:switch_to_insert(old_cursor, tail_cursor)
    else
        noautocmd wincmd p
    endif
endfunction
"

" scroll_quickfix() -- Scroll quickfix without change focus
" @param dir  0 -- up  1 -- down
" @param mode 'i' -- insert 'n' -- normal
"
function tools#scroll_quickfix(dir, mode)
    let current_winid = win_getid()
    let quickfix_winid = getqflist({'winid': 0}).winid
    if quickfix_winid == 0
        echomsg "There is no quickfix window"
        return
    endif
    " scroll
    call win_gotoid(quickfix_winid)
    if a:dir == 0
        exec "normal! \<C-U>"
    elseif a:dir == 1
        exec "normal! \<C-D>"
    endif
    call win_gotoid(current_winid)
    if a:mode == 'i'
        exec "normal! l"
        startinsert
    endif

endfunction

" "

" ensure_dir_exist() -- Ensure directory exists
" if @dir exists, just exit.
" if @dir not exists, create it
function! tools#ensure_dir_exist(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction
"

" create_qt_project() -- Create Qt project
" TODO: refactor code to platform-dependent
function tools#create_qt_project(type, to)
    if a:type != "QMainWindow" && a:type != "QWidget" && a:type != "QDialog"
        echoerr "Please input correct argument"
    endif
    if !isdirectory(a:to)
        echoerr "Please input correct argument"
    endif
    call system("cp " . "$HOME/.config/nvim/tools/Qt/" . a:type . "/* " . a:to)
    call writefile("", ".root")
    silent !cmake -S. -B_builds
    call system("ln -s _builds/compile_commands.json .")
    if !v:shell_error
        echomsg "create_qt_project(): successfull"
    else
        echomsg "create_qt_project(): failed to copy templates"
    endif
endfunction
"

" Integrate lightline and ale
function! g:LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ▲', all_non_errors)
endfunction

function! g:LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! g:LightlineLinterOK() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '✓' : ''
endfunction
"

" Debug gutentags
function tools#debug_gutentgs()
    let g:gutentags_define_advanced_commands = 1
    let g:gutentags_trace = 1
endfunction

function tools#undebug_gutentags()
    let g:gutentags_define_advanced_commands = 0
    let g:gutentags_trace = 0
endfunction
"

" Switch tag system
function tools#use_static_tag() abort
    let g:general#only_use_static_tag = 1
    if &csprg == 'gtags-cscope'
        nnoremap <silent> gs :GscopeFind s <C-R><C-W><cr>:cnext<CR>zz
        nnoremap <silent> gd :GscopeFind g <C-R><C-W><cr>:cnext<CR>zz
        nnoremap <silent> gc :GscopeFind c <C-R><C-W><cr>:cnext<CR>zz
        nnoremap <silent> gt :GscopeFind t <C-R><C-W><cr>:cnext<CR>zz
        nnoremap <silent> gC :GscopeFind d <C-R><C-W><cr>:cnext<CR>zz
        nnoremap <silent> gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
    else
        nnoremap <silent> gc :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gt :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gs :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gd :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gC :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gi :echoerr 'gtags-scope is not available'<CR>
    endif
    if &filetype == 'rust'
        nnoremap <silent> gi :echoerr 'Rust does not use header/source model'<CR>
    endif
endfunction

function tools#use_lsp_tag() abort
    let g:general#only_use_static_tag = 0
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gs <Plug>(coc-references)
    nmap <silent> gt <Plug>(coc-type-definition)
    if &filetype == 'c' || &filetype == 'cpp'
        nmap <silent> gc :call CocLocations('ccls','$ccls/call')<CR>
        nmap <silent> gC :call CocLocations('ccls','$ccls/call', {'callee': v:true})<CR>
        if &csprg == 'gtags-cscope'
            nnoremap <silent> gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
        else
            nnoremap <silent> gi :echoerr 'gtags-scope is not available'<CR>
        endif
    elseif &filetype =='rust'
        nmap <silent> gi <Plug>(coc-implementation)
        if &csprg == 'gtags-cscope'
            nnoremap <silent> gc :GscopeFind c <C-R><C-W><cr>:cnext<CR>zz
            nnoremap <silent> gC :GscopeFind d <C-R><C-W><cr>:cnext<CR>zz
        else
            nnoremap <silent> gc :echoerr 'gtags-scope is not available'<CR>
            nnoremap <silent> gC :echoerr 'gtags-scope is not available'<CR>
        endif
    endif
endfunction
"

" Plugin operations
function tools#plugin_clean()
	let unused_plugin_dir = dein#check_clean()
	if len(unused_plugin_dir) == 0
		echomsg "There is no unused plugin"
		return
	endif
	for dir in unused_plugin_dir
		try
			call delete(dir, 'rf')
		catch /.*/
			echoerr "remove unused plugin directory failed"
		endtry
		echomsg "removed unused plugin directory"
	endfor
endfunction

function tools#plugin_recache()
	try
		call dein#clear_state()
		call dein#recache_runtimepath()
	catch /.*/
		echoerr "Error in tools#PluginRecache"
	endtry
endfunction

function tools#plugin_reinstall(list)
    if type(a:list) == type([])
        call call('dein#reinstall', a:list)
    endif
endfunction
"

" NERDTree

" Only used by tools#nerdtree_XXXX()
function s:get_last_accessed_buf_path() abort
    let l:last_accessed_buffer_path = bufname(t:last_accessed_winnr)
    if empty(l:last_accessed_buffer_path)
        let l:last_accessed_buffer_path = utils#current_path()
    else
        let l:last_accessed_buffer_path = getcwd() .. g:general#delimiter .. l:last_accessed_buffer_path
    endif
    " :echomsg l:last_accessed_buffer_path
    return l:last_accessed_buffer_path
endfunction

function tools#nerdtree_toggle_outermost_dir() abort
    if t:nerdtree_open_mode.outermost == 1
        let t:nerdtree_open_mode = map(t:nerdtree_open_mode, {key, val -> 0})
        :NERDTreeClose
    else
        let l:last_accessed_buffer_path = <SID>get_last_accessed_buf_path()
        execute ':NERDTree' utils#get_outermost_dir(l:last_accessed_buffer_path)
        let t:nerdtree_open_mode.outermost = 1
    endif
endfunction

function tools#nerdtree_toggle_innermost_dir() abort
    if t:nerdtree_open_mode.innermost == 1
        :NERDTreeClose
    else
        let l:last_accessed_buffer_path = <SID>get_last_accessed_buf_path()
        execute ':NERDTree' utils#get_innermost_dir(l:last_accessed_buffer_path)
        let t:nerdtree_open_mode.innermost = 1
    endif
endfunction

function tools#nerdtree_close() abort
    :NERDTreeClose
endfunction

function tools#nerdtree_toggle_root() abort
    if t:nerdtree_open_mode.root == 1
        :NERDTreeClose
    else
        let l:last_accessed_buffer_path = <SID>get_last_accessed_buf_path()
        " :echomsg l:last_accessed_buffer_path
        execute ':NERDTree' utils#get_root_dir(l:last_accessed_buffer_path)
        let t:nerdtree_open_mode.root = 1
    endif
endfunction

