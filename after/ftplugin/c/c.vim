" Settings for C
" Last Change: 2021-05-15
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0
execute 'source' g:general#vimfiles .. g:general#delimiter .. 'after' .. g:general#delimiter .. 'ftplugin' .. g:general#delimiter .. 'common.vim'

syntax sync fromstart

" Support Chinese version of GNU Make
setlocal errorformat+=
            \%D%*\\a[%*\\d]:\ 进入目录“%f”,
            \%X%*\\a[%*\\d]:\ 离开目录“%f”,
            \%D%*\\a:\ 进入目录“%f”,
            \%X%*\\a:\ 离开目录“%f”,
            \%-GIn\ file\ included\ from\ %f:%l:%c,
            \%-GIn\ file\ included\ from\ %f:%l,
            \%-Gfrom\ %f:%l,
            \%-Gfrom\ %f:%l:%c

let b:ale_linters = []
" Highlight text that goes over the 80 column limit
if &background == 'light'
    highlight OverLength ctermfg=243 ctermbg=153 guifg=#76787b guibg=#e4effb
else
    highlight OverLength term=reverse ctermbg=237 guibg=#393e53
endif
match OverLength /\%81v.\+/

if !g:general#only_use_static_tag
    nmap <buffer> <silent> gc :call CocLocations('ccls','$ccls/call')<CR>
    nmap <buffer> <silent> gC :call CocLocations('ccls','$ccls/call', {'callee': v:true})<CR>
endif

" This comands are defined for ccls(only supports C/C++)
command! -nargs=0 Derived :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})
command! -nargs=0 Base :call CocLocations('ccls','$ccls/inheritance')
command! -nargs=0 VarAll :call CocLocations('ccls','$ccls/vars')
command! -nargs=0 VarLocal :call CocLocations('ccls','$ccls/vars', {'kind': 1})
command! -nargs=0 VarArg :call CocLocations('ccls','$ccls/vars', {'kind': 4})
command! -nargs=0 MemberFunction :call CocLocations('ccls','$ccls/member', {'kind': 3})
command! -nargs=0 MemberType :call CocLocations('ccls','$ccls/member', {'kind': 2})
command! -nargs=0 MemberVar :call CocLocations('ccls','$ccls/member', {'kind': 4})
