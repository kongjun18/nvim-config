""""""""""""""""
" Status
""""""""""""""""
let s:indicator_infos = '💡'
let s:indicator_warnings = '⚠️'
let s:indicator_errors = '✖'
let s:indicator_ok = '✓'
let s:indicator_checking = ''

let s:mode = {
      \ 'n': 'NORMAL',
      \ 'v': 'VISUAL',
      \ 's': 'VISUAL',
      \ 'r': 'REPLEACE',
      \ 'i': 'INSERT',
      \ 'c': 'COMMAND'
      \ }

" VISUAL
" SELECT(VIS
" REPLACE
" INSERT
" FILENAME
" STATUSLINE
let s:guibg = {
      \ 'n': '#98C379',
      \ 'v': '#C678DD',
      \ 's': '#C678DD',
      \ 'r': '#E06B75',
      \ 'i': '#61AFF0',
      \ 'c': 'Red',
      \ 'f': '#BFBFBF',
      \ 'l': '#D0D0D0',
      \ }

      " \ 'l': '#F0F0F0',
""""""""""""""""
" Highlight
""""""""""""""""
function! s:highlight_mode() abort
  execute printf('hi Mode guifg=%s guibg=%s', 'White', s:guibg[tolower(mode())])
endfunction

execute printf('hi File guifg=%s guibg=%s', 'Black', s:guibg['f'])
execute printf('hi StatusLine guifg=%s guibg=%s', 'Black', s:guibg['l'])

""""""""""""""""
" Auxiliary
""""""""""""""""

function! statusline#infos() abort
  if !statusline#linted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.info == 0 ? '' : printf(s:indicator_infos . '%d', l:counts.info)
endfunction

function! statusline#warnings() abort
  if !statusline#linted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_warnings = l:counts.warning + l:counts.style_warning
  return l:all_warnings == 0 ? '' : printf(s:indicator_warnings . '%d', all_warnings)
endfunction

function! statusline#ok() abort
  if !statusline#linted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? s:indicator_ok : ''
endfunction

function! statusline#errors() abort
  if !statusline#linted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  return l:all_errors == 0 ? '' : printf(s:indicator_errors . '%d', all_errors)
endfunction

function! statusline#checking() abort
  return ale#engine#IsCheckingBuffer(bufnr('')) ? s:indicator_checking : ''
endfunction

function! statusline#linted() abort
  return get(g:, 'ale_enabled', 0) == 1
    \ && getbufvar(bufnr(''), 'ale_enabled', 1)
    \ && getbufvar(bufnr(''), 'ale_linted', 0) > 0
    \ && ale#engine#IsCheckingBuffer(bufnr('')) == 0
endfunction

""""""""""""""""
" APIs
""""""""""""""""
function! statusline#status() abort
  return join([statusline#checking(), statusline#errors(), statusline#warnings(), statusline#infos(), statusline#ok()])
endfunction

function! statusline#mode() abort
  call s:highlight_mode()
  return s:mode[tolower(mode())]
endfunction

