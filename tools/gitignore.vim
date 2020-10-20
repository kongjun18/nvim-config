" Vim global plugin for creating .gitignore
" Last Change: 2020-10-22
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

" @filetype: c, cpp, rust, python
" @note:     only impletemt c and cpp
function g:CreateGitignore(filetype)
    if filereadable('.gitignore')
        echomsg "This project had .gitignore"
        return 
    endif

    let gitignore_connent = []
    if a:filetype == 'c' && a:filetype == 'cpp'
        call add(gitignore_connent, "# CMake-generated file")
        call add(gitignore_connent, "_builds")
        call add(gitignore_connent, "compile_commands.json")
        call add(gitignore_connent, "\n")

        call add(gitignore_connent, "# fd dotfile")
        call add(gitignore_connent, ".fdignore")
        call add(gitignore_connent, "\n")

        call add(gitignore_connent, "# rg dotfile")
        call add(gitignore_connent, ".fdignore")
        call add(gitignore_connent, "\n")

        call add(gitignore_connent, "# Vim-generated file")
        call add(gitignore_connent, ".root")
        call add(gitignore_connent, ".project")
        call add(gitignore_connent, ".swp")
        call add(gitignore_connent, ".session")
        call add(gitignore_connent, "session")
        call add(gitignore_connent, "swp")
        call add(gitignore_connent, ".undo")
        call add(gitignore_connent, "undo")
        call add(gitignore_connent, "projectins.json")
        call add(gitignore_connent, ".ycm_extra_config.py")
        call add(gitignore_connent, '.notags')
        call add(gitignore_connent, "\n")
        
        call add(gitignore_connent, "# object file")
        call add(gitignore_connent, "*.o")
        call add(gitignore_connent, "*.tmp") 
        call add(gitignore_connent, "*.bin")
        call add(gitignore_connent, "\n")

        call writefile(gitignore_connent, '.gitignore')
    endif
endfunction
