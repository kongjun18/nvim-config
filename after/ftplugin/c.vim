" Settings for C
" Last Change: 2021-02-10
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0
execute 'source' g:general#vimfiles .. g:general#delimiter .. 'after' .. g:general#delimiter .. 'ftplugin' .. g:general#delimiter .. 'common.vim'

" Support Chinese version of GNU Make
setlocal errorformat+=
            \%D%*\\a[%*\\d]:\ 进入目录“%f”,
            \%X%*\\a[%*\\d]:\ 离开目录“%f”,
            \%D%*\\a:\ 进入目录“%f”,
            \%X%*\\a:\ 离开目录“%f”

if !g:general#only_use_static_tag
    nmap <silent> gc :call CocLocations('ccls','$ccls/call')<CR>
    nmap <silent> gC :call CocLocations('ccls','$ccls/call', {'callee': v:true})<CR>
else
    if &csprg == 'gtags-cscope'
        nnoremap <silent> gc :GscopeFind c <C-R><C-W><cr>
        nnoremap <silent> gC :GscopeFind d <C-R><C-W><cr>
    else
        nnoremap <silent> gc :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gC :echoerr 'gtags-scope is not available'<CR>
    endif
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
