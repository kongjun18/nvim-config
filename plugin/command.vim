" Customed commands
" Last Change: 2021-01-13
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

" Edit system-wide tasks.ini
command! TaskEdit silent exec 'vsp ' . general#vimfiles . '/tasks.ini'
" Edit autoload/tools.vim
command ToolEdit :exec 'vsp ' . general#vimfiles . '/autoload/tools.vim'

" Use static tag system instead of LSP
command -nargs=0 UseStaticTag call tools#use_static_tag()

" Debug gutentags
command -nargs=0 DebugGutentags call tools#debug_gutentgs()
command -nargs=0 UndebugGutentags call tools#undebug_gutentags()

" Command wrappers of dein.vim
command! -nargs=0 PlugInstall call dein#install()
command! -nargs=0 PlugUpdate call dein#update()
command! -nargs=0 PlugClean call tools#plugin_clean()
command! -nargs=0 PlugRecache call tools#plugin_recache()
command! -nargs=? PlugReinstall 
            \ if empty('<args>')                        |
            \   echohl WarnningMsg                      |
            \   echomsg "Require one or more arguments" |
            \   echohl None                             |
            \ else                                      |
            \   call tools#plugin_reinstall(args)       |
            \ endif

" Save current buffer and switch to source/header file 
command -nargs=0 W :w | A

" Echo current buffer path
command -nargs=0 EchoBufferPath :echo expand('%:p')

" Create Qt project
command -nargs=1 -complete=customlist,ListQtType CreateQt :call tools#create_qt_project('<args>', getcwd()) | :e main.cpp | :silent CocRestart
function ListQtType(A, L, P)
    return ["QMainWindow", "QWidget", "QDialog"]
endfunction
