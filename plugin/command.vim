" Customed commands
" Last Change: 2021-10-11
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

" Edit system-wide tasks.ini
command! TaskEdit silent exec 'vsp ' . general#vimfiles . '/tasks.ini'
" Edit autoload/tools.vim
command ToolEdit :exec 'vsp ' . general#vimfiles . '/autoload/tools.vim'

" Use static tag system instead of LSP
command -nargs=0 UseStaticTag call tools#use_static_tag()
command -nargs=0 UseLspTag call tools#use_lsp_tag()

" Debug gutentags
command -nargs=0 DebugGutentags call tools#debug_gutentgs()
command -nargs=0 UndebugGutentags call tools#undebug_gutentags()

" Save current buffer and switch to source/header file
command! -nargs=0 W :w | A

" Echo current buffer path
command -nargs=0 EchoBufferPath :echo expand('%:p')

" Create .vimspector.json
command -nargs=0 CreateVimspector :call tools#create_vimspector(utils#get_root_dir(utils#current_path()))

" Create Qt project
command -nargs=1 -complete=customlist,ListQtType CreateQt :call tools#create_qt_project('<args>', getcwd()) | :e main.cpp | :silent CocRestart
function ListQtType(A, L, P)
    return ["QMainWindow", "QWidget", "QDialog"]
endfunction

" Display files that have conflicts in quickfix
command -nargs=0 Merge :call asyncrun#run('', {'errorformat': '%f'}, "git diff --name-only --diff-filter=U")

" Write buffer to privileged file
command! -nargs=0 SudoWrite :execute 'silent! write !sudo tee "%" > /dev/null' | edit!

" Rename current file
command! -nargs=1 Rename try | execute "saveas %:p:h" . g:general#delimiter . "<args>" | call delete(expand('#')) | bd # | endtry
