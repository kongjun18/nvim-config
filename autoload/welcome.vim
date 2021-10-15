" Welcome screen
" Last Change: 2021-10-11
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0
if exists('loaded_welcome_vim') || &cp
    finish
endif
let loaded_welcome_vim = 1
" TODO: 这里是吗？
let s:chinese = ['老', '子', '道', '德', '经', ' ', ' ', ' ', ' ', ']
function! welcome#open()
    let chapter = s:randnum(81) + 1
    " TODO: 创建文件
    let file = readfile(expand(printf('~/.config/nvim/TaoTeTing/%d', chapter)), '')
    " Calculate rows and columns
    let chars = 0
    for l in file
        let chars += strchars(l)
    endfor
    let row = 18
    let col = chars / row + ((chars % row) != 0)
    " Convert regular raw text to a multidementional array
    let content = []
    let chars = 0
    for i in range(row)
        call add(content, [])
    endfor
    for l in file
        for i in range(strchars(l))
            let chars = (chars + 1) % row
            call insert(content[chars-1], strcharpart(l, i, 1))
        endfor
    endfor
    " Create horizonal rotated text
    let g:welcome#bufid = utils#scratch_buf()
    call assert_true(g:welcome#bufid > 0)
    let editor_width = utils#editor_width()
    let editor_height = utils#editor_height()
    for line in content
        let length = len(line)
        " The width of Chinese character is equal to 2 space
        " TODO: ensure text resides at the middle of screen
        call insert(line, repeat(' ', 3*(col-length) + (editor_width-8*col)/2))
    endfor
    " Create header
    let lnum = (editor_height-2-row)/2 " The statusline takes two lines
    call s:appendbufline(g:welcome#bufid, 0, repeat([''], lnum - 5))
    " TODO: refine
    let chapter = s:nr2chinese(chapter)
    let header = ['
', '
', '
', '
', '
    let header_offset = (editor_width-8*col)/2+3*col+4
    let empty = repeat(' ', header_offset)
    let i = len(header)
    for c in header
        call s:appendbufline(g:welcome#bufid, lnum-i, empty . chapter[5 - i] . '  ' . c)
        let i -= 1
    endfor
    " Insert horizonal rotated text
    for i in range(len(content))
        call assert_true(s:appendbufline(g:welcome#bufid, lnum, join(content[i])) == 0)
        let lnum += 1
    endfor
    " Insert empty lines
    call assert_true(s:appendbufline(g:welcome#bufid, lnum, repeat([''], editor_height - lnum)))
    " Switch to scratch-buffer
    noautocmd execute 'buffer '  . g:welcome#bufid
    noautocmd setlocal nonumber norelativenumber cursorline
    " Clear overlength highlight
    match none
    " Clear undo history
        let old_undolevels = getbufvar(g:welcome#bufid, '&undolevels')
        noautocmd setlocal undolevels=-1
        noautocmd exe "normal a \<BS>\<Esc>"
    call setbufvar(g:welcome#bufid, '&undolevels', old_undolevels)
endfunction
function! s:randnum(max) abort
  return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % a:max
endfunction
function! s:appendbufline(expr, lnum, text)
    noautocmd let fail = appendbufline(a:expr, a:lnum, a:text)
    return fail
endfunction
function! s:nr2chinese(nr) abort
    let str = [ ]
    let nr = a:nr
    let i = 10
    let n = a:nr % i
    while nr > 0
        call insert(str, s:chinese[n - 1])
        let i *= 10
        let nr /= 10
        let n = nr % i
    endwhile
    if len(str) == 2 && str[1] != '
        call insert(str, ' ', 1)
    elseif len(str) == 1
        call insert(str, '  ')
        call add(str, '  ')
    else
        call insert(str, '  ')
    endif
    call insert(str, '  ')
    call add(str, '  ')
    return str
endfunction
