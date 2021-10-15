" Preview quickfix item in popup window
" Last Change: 2021-08-10
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0
" TODO: 
let s:status = {} " Record all private status
" TODO: 
 s:status
function! qfpreview#close()
    if get(s:status, 'popup_id', -1) > 0
        call nvim_win_close(s:status.popup_id, v:false)
    endif
    if get(s:status, 'opened', v:false) == v:true
        let s:status.bufid = -1
        let s:status.popup_id = -1
    endif
    let s:status.opened = v:false
endfunction
" TODO: 
s:status
" TODO: 
 quickfix 
 b:changedtick
function! qfpreview#open()
    call qfpreview#close()
    if !has_key(s:status, 'items')
        let s:status.items = getqflist()
    endif
    let items = s:status.items
    if empty(items)
        call utils#errmsg("There is no quickfix or has a empty quickfix")
        return
    endif
    let qf_wid = getqflist({'winid':1}).winid
    call assert_true(qf_wid > 0)
    " 
    " TODO: 
statusline
    let r = utils#editor_height() - winheight(qf_wid) - 10
    let h = 15
    let w = utils#editor_width() - 8
    " FIX: border 
    let s:status.win_opts = #{
                \ relative:'editor', anchor:'SW',
                \ width:w, height:h, row:r, col:4,
                \ border: 'single',
                \ noautocmd: v:true,
                \ }
    let index = line('.')
    " :echomsg 'index ' index
    call assert_true(exists('s:status.items'))
    call assert_inrange(1, len(s:status.items), index, 'index is out of range' )
    let index -= 1
    let item = items[index]
    call assert_true(item.valid)
    call assert_true(item.bufnr > 0)
    let name = bufname(item.bufnr)
    silent let s:status.bufid = bufadd(name)
    silent call bufload(s:status.bufid)
    " TODO: 
    let s:status.bufline = item.lnum
    call qfpreview#dislay()
endfunction
function! qfpreview#dislay()
    try
        call assert_true(exists('s:status.win_opts'))
        call assert_true(get(s:status, 'bufid', -1) > 0)
        let s:status.popup_id = nvim_open_win(s:status.bufid, v:false, s:status.win_opts)
        call win_execute(s:status.popup_id, 'setlocal signcolumn=no norelativenumber')
        call assert_true(get(s:status, 'bufline', -1) > 0)
        call win_execute(s:status.popup_id, 'normal! ' .. s:status.bufline .. 'Gzz')
        call win_execute(s:status.popup_id, 'setlocal cursorline')
        let s:status.opened = v:true
    catch /.*/
        call qfpreview#close()
        call utils#excepmsg()
    endtry
endfunction
" -----------------------------------------
"                  Test
" -----------------------------------------
command! -nargs=0 QFPreviewOpen :call qfpreview#open()
command! -nargs=0 QFPreviewClose :call qfpreview#close()
" TODO: 
