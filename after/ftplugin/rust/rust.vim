" Configuration of Rust
" Last Change: 2020-11-11
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

execute 'source' g:general#vimfiles .. g:general#delimiter .. 'after' .. g:general#delimiter .. 'ftplugin' .. g:general#delimiter .. 'common.vim'

setlocal makeprg=cargo\ $*
if !g:general#only_use_static_tag
    nmap <silent> gi <Plug>(coc-implementation)
else
    nnoremap <silent> gi :echoerr 'Rust does not use header/source model'<CR>
endif
setlocal errorformat=
			\%-G,
			\%-Gerror:\ aborting\ %.%#,
			\%-Gerror:\ Could\ not\ compile\ %.%#,
			\%Eerror:\ %m,
			\%Eerror[E%n]:\ %m,
			\%Wwarning:\ %m,
			\%Inote:\ %m,
			\%C\ %#-->\ %f:%l:%c,
			\%-G%\\s%#Downloading%.%#,
			\%-G%\\s%#Compiling%.%#,
			\%-G%\\s%#Finished%.%#,
			\%-G%\\s%#error:\ Could\ not\ compile\ %.%#,
			\%-G%\\s%#To\ learn\ more\\,%.%#,
			\%-Gnote:\ Run\ with\ \`RUST_BACKTRACE=%.%#,
			\%.%#panicked\ at\ \\'%m\\'\\,\ %f:%l:%c



