" Vim general setting
" Last Change: 2020-12-26
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

set nocompatible

if exists('g:loaded_general_vim') || &cp || version < 700
    finish
endif
let g:loaded_general_vim = 1

if has('unix')
    let g:is_unix = 1
    let g:is_windows = 0
    let g:vimrc = $HOME . "/.config/nvim/init.vim"
    let g:vimfiles = $HOME . "/.config/nvim"
    let g:plugin_dir = $HOME . "/.config/nvim/plugged"
    let g:backup_dir = $HOME . "/.config/nvim/.backup"
    let g:swap_dir = $HOME . "/.config/nvim/.swap"
    let g:undo_dir = $HOME . "/.config/nvim/.undo"
    let g:session_dir = $HOME . "/.config/nvim/.session"
    let g:dein_file = g:plugin_dir . '/repos/github.com/Shougo/dein.vim'
elseif has('win32')
    let g:is_windows = 1
    let g:is_unix = 0
    let g:vimrc = $HOME . "\\_vimrc"
    let g:vimfiles = $HOME . "\\vimfiles"
    let g:plugin_dir = $HOME . "\\vimfiles\\plugged"
    let g:backup_dir = $HOME . "\\vimfiles\\.backup"
    let g:swap_dir = $HOME . "\\vimfiles\\.swap"
    let g:undo_dir = $HOME . "\\vimfiles\\.undo"
    let g:session_dir = $HOME . "\\vimfiles\\.session"
    let g:dein_file = g:plugin_dir . '\\repos\\github.com\\Shougo\\dein.vim'
endif
let g:only_use_static_tag = 0
let g:grepper = 'grep'
let g:findder = 'find'
if executable('fd')
	let g:findder = 'fd'
endif
if executable('rg')
	let g:grepper = 'rg'
	set grepprg=rg\ --ignore-case\ --vimgrep\ $*   " substitute grep with ripgrep
endif
let g:project_root_maker = ['.root', '.git', '.pro', 'Cargo.toml', 'compile_commands.json']

call tools#ensure_dir_exist(g:backup_dir)
call tools#ensure_dir_exist(g:swap_dir)
call tools#ensure_dir_exist(g:undo_dir)
call tools#ensure_dir_exist(g:session_dir)
let &backupdir = g:backup_dir . '/'
let &directory = g:swap_dir . '/'
let &undodir = g:undo_dir . '/'
let g:session_directory = g:session_dir

" Leader
let mapleader=' '
let maplocalleader='z'

" Disable standard plugins except of matchit
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

set path+=include
set backspace=indent,eol,start
set mouse=r
set foldmethod=marker
set laststatus=2    " always show status line
set number
set showtabline=2
set noerrorbells    " No beep
set vb t_vb=        
set undofile        " Persist undo history
set backup          " Backup files
set wildignore=*.o,*.obj,*.bin,*.img,*.lock,.git "Ignore files when expanding wildcards
set hlsearch    " Highlight matched pattern
set incsearch   " Show matched pattern when type regex
set wrapscan    " Search wrap around the end of the file
set nopaste     " Don't enable paste mode.
set ignorecase  " If type lowercase letter, search both lowercase and uppercase.
set smartcase   " If type uppercase letter, only search uppercase letter.
set ttimeout
set ttimeoutlen=50
set encoding=utf-8  " Use utf-8 to encode string
set termencoding=utf-8
set smartindent     " Do smart autoindenting when staring a new line
set cursorline      " Show current line
set nowrap          " Don't wrap long line
set linebreak       " Don't wrap lone line in the boundary of word
set showmatch       " Highlight matched pair and bracket when insert it
set expandtab       " Transform tab to space
set tabstop=4       " One tap counts for 4 spaces
set shiftwidth=4    " Use 4 spaces for each step of (auto)indent
set noshowmode      " Don't use show current edit mode. I use lightline.
set showcmd         " Show command in the last line of the screen.
set noautochdir     " Don't change working directory automatically. I always launch Vim at the root of the project .
set wildmenu        " Enhance command completion
set wildmode=full   "
set shortmess+=c    " Don't give ins-completion-menu messages

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif

" suppress the output of external program
"
" I use fish shell, so give it extra attention
if g:is_unix && &shell =~? 'fish'
	set shellpipe=&>\ %s
endif

" Turn on true color
if has('nvim')
	" Enable true color
	set termguicolors
elseif has('termguicolors')
	" Fix bug for Vim
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
else
	" 8-bit color
	set t_Co=256
endif

" Skip python search to accelerate startup time
if g:is_unix
    let g:python_host_skip_check=1
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_skip_check=1
    let g:python3_host_prog = '/usr/bin/python3'
endif

" Sourece keymap setting 
for keymap in  globpath(g:vimfiles, 'keymap/*.vim', 0, 1)
    exec "source " . keymap
endfor

" Automatically change working directory to Documents
if g:is_windows
    autocmd VimEnter * cd ~/Documents
endif
"}}}
