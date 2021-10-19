" utilities for vimscript
" Last Change: 2021-10-19
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

" utils#get_basename(path)
" parm path filename of abusolute path
" return basename of a:path
" error return empty string
" TODO: support windows
function utils#get_basename(path) abort
    if type(a:path) != v:t_string
        return ''
    endif
    if utils#is_basename(a:path)
        return a:path
    endif

    let l:path = a:path
    if g:general#is_unix
        if !empty(matchstr(l:path, '/[^/]\+$'))
            let l:path = substitute(l:path, '.*/', '', '')
            return l:path
        endif
    else
        " Windows: TODO
    endif
endfunction
"

" utils#is_basename(path)
function utils#is_basename(path)
    if g:general#is_unix
        return empty(matchstr(a:path, '/'))
    else
        return empty(matchstr(a:path, '^\a+:')) && empty(matchstr(a:path, '\'))
    endif
endfunction
"

" utils#up(apath)
" parm apath abusolute path
" return parent directory(empty string is a:apath is root)
" TODO: support windows
function utils#up(apath)
    let l:parent_dir =  substitute(a:apath, '/[^/]\+$', '', '')
    if empty(l:parent_dir)
        let l:parent_dir = '/'
    elseif l:parent_dir == '/'
        let l:parent_dir = ''
    endif
    return l:parent_dir
endfunction
"

" utils#get_dir_entries(apath)
" return all entries including dotfiles of directory a:apath
" TODO support windows
function utils#get_dir_entries(apath)
    let l:entries = glob(a:apath .. '/*', v:true, v:true)
    let l:entries += glob(a:apath .. '/.*', v:true, v:true)
    return l:entries
endfunction
"

" utils#current_path()
" If there is an editing buffer, return it's path. Otherwise, return a
" non-existing file path in the current working directory for convenience.
function utils#current_path()
    let l:bufname = expand('%:p')
    let l:convenience_path = getcwd()
    if empty(l:bufname)
        let l:convenience_path = g:general#is_unix ? l:convenience_path .. '/for-implement-convenience'
                    \: l:convenience_path .. '\for-implement-convenience'
        return l:convenience_path
    endif
    return l:bufname
endfunction
"

" utils#get_root_dir(path) -- Get the project root directory
" @parm path relative/absolute path
" @return project root directory
" @note respect the precedence of g:general#project_root_makers
" TODO support windows
function utils#get_root_dir(path) abort
    let l:project_root_makers =  deepcopy(g:general#project_root_makers)
    let l:project_root_dir = ''
    for l:maker in l:project_root_makers
        let l:project_root_dir = findfile(l:maker, a:path .. ';')
        let l:current_path = utils#current_path()
        if !empty(l:project_root_dir)
            break
        endif
        let l:project_root_dir = finddir(l:maker, a:path .. ';')
        if !empty(l:project_root_dir)
            break
        endif
    endfor

    if g:general#is_unix
        " The current file don't resieds in any projects
        if empty(l:project_root_dir)
            return ''
        endif

        if empty(matchstr(l:project_root_dir, '/'))
            let l:maker = l:project_root_dir
            " No buffer
            let l:project_root_dir = utils#current_path()
            " Find maker in the parent directory
            let l:root_is_found = v:false
            while (!l:root_is_found)
                for l:item in utils#get_dir_entries(l:project_root_dir)
                    if l:item =~# '\.*/\' .. l:maker
                        return l:project_root_dir
                    endif
                endfor
                let l:project_root_dir = utils#up(l:project_root_dir)
            endwhile
        else
            let l:project_root_dir = utils#up(l:project_root_dir)
        endif
    else
        " TODO
    endif
    return l:project_root_dir
endfunction


" utils#get_outermost_dir(path)
" parm path ralative/abusolute path
" return outermost directory containing current file in project
function utils#get_outermost_dir(path)
    let l:project_root_dir = utils#get_root_dir(a:path)
    if empty(l:project_root_dir)
        return ''
    endif
    let l:outermost_dir = a:path
    " :echomsg 'l:project_root_dir:' l:project_root_dir
    " :echomsg 'l:outermost_dir:' l:outermost_dir
    while l:project_root_dir !=# utils#up(l:outermost_dir)
        let l:outermost_dir = utils#up(l:outermost_dir)
    endwhile
    return l:outermost_dir
endfunction
"

" get_innermost_dir(path)
" parm path ralative/abusolute path
" return innermost directory containing current file in project
function utils#get_innermost_dir(path)
    let l:root_dir = utils#get_root_dir(a:path)
    if empty(l:root_dir)
        return ''
    endif
    return utils#up(a:path)
endfunction


" utils#nvim_is_latest() -- Determine whether neovim is lastest
"
" This function is hard-coded. Only check neovim is whether 0.5.0 or not because neovim installed in different ways has
" different version output.
"
" I write this function to determine whether install nvim-treesitter which
" requires lastest neovim or not.
"
function! utils#nvim_is_latest()
    if !has('nvim')
        return 0
    endif
    redir => l:s
    silent! version
    redir END
    let l:version_message =  matchstr(l:s, 'NVIM v\zs[^\n]*')
    let l:nvim_version = matchstr(l:version_message, '\d\.\d\.\d')
    let l:nvim_version_list = split(l:nvim_version, '\.')
    if l:nvim_version_list[0] != 0
        return 0
    elseif l:nvim_version_list[1] < 5
        return 0
        " Because lastest version is 0.5.0, so don't need check last number.
    endif

    return 1
endfunction

" Copy file a:apath to a:dir
function utils#copy(apath, dir)
    if type(a:apath) != v:t_string || type(a:dir) != v:t_string
        echoerr "utils#copy(): arguments type error"
    endif
    let l:content = readfile(a:apath)
    if !empty(l:content)
        let l:to = a:dir .. '/' .. utils#get_basename(a:apath)
        if !filereadable(l:to)
            call writefile(l:content, l:to)
        endif
    endif
endfunction

" Ensure directory exists
" If dir exists, just exit. Otherwise, create it.
function! utils#ensure_dir_exist(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction
"


