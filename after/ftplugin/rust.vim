" Configuration of Rust
" Last Change: 2020-11-11
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

setlocal makeprg=cargo\ $*
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



