" Settings for C++
" Last Change: 2021-01-16
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

if !g:general#only_use_static_tag
    nmap <silent> gc :call CocLocations('ccls','$ccls/call')<CR>
    nmap <silent> gC :call CocLocations('ccls','$ccls/call', {'callee': v:true})<CR>
else
    if &csprg == 'gtags-cscope'
        nnoremap <silent> gc :GscopeFind c <C-R><C-W><cr>:cnext<CR>zz
        nnoremap <silent> gC :GscopeFind d <C-R><C-W><cr>:cnext<CR>zz
    else
        nnoremap <silent> gc :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gC :echoerr 'gtags-scope is not available'<CR>
    endif
endif
