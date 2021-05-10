" Vim general setting
" Last Change: 2021-05-10
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

set nocompatible

if exists('g:loaded_general_vim') || &cp || version < 700
    finish
endif
let g:loaded_general_vim = 1

if has('unix')
    let general#is_unix = 1
    let general#is_windows = 0
    let general#vimrc = $HOME . '/.config/nvim/init.vim'
    let general#gvimrc = $HOME . '/.gvimrc'
    let general#vimfiles = $HOME . '/.config/nvim'
    let general#plugin_dir = general#vimfiles . '/plugged'
    let general#backup_dir = general#vimfiles . '/.backup'
    let general#swap_dir = general#vimfiles . '/.swap'
    let general#undo_dir = general#vimfiles . '/.undo'
    let general#session_dir = general#vimfiles . '/.session'
    let general#dein_file = general#plugin_dir . '/repos/github.com/Shougo/dein.vim'
    let general#delimiter = '/'
    " suppress the output of external program
    " I use fish shell, so give it extra attention
    if &shell =~? 'fish'
        set shellpipe=&>\ %s
    endif

    " Skip python search to accelerate startup time
    let g:python_host_skip_check=1
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_skip_check=1
    let g:python3_host_prog = '/usr/bin/python3'
elseif has('win32')
    let general#is_windows = 1
    let general#is_unix = 0
    let general#vimrc = $HOME .. '\_vimrc'
    let general#vimfiles = $HOME .. '\vimfiles'
    let general#gvimrc = $HOME .. '\_gvimrc'
    let general#plugin_dir = general#vimfiles . '\plugged'
    let general#backup_dir = general#vimfiles . '\.backup'
    let general#swap_dir = general#vimfiles . '\.swap'
    let general#undo_dir = general#vimfiles . '\.undo'
    let general#session_dir = general#vimfiles . '\.session'
    let general#dein_file = general#plugin_dir . '\repos\github.com\Shougo\dein.vim'
    let general#delimiter = '\'
    " Use the Documents as default working directory
	:cd $HOME\Documents
endif
let general#nvim_is_latest = utils#nvim_is_latest()
let general#only_use_static_tag = 0
let general#use_gtags_at_startup = 0
let general#grepper = 'grep'
let general#findder = 'find'
if executable('fd')
	let general#findder = 'fd'
endif
if executable('rg')
	let general#grepper = 'rg'
	set grepprg=rg\ --ignore-case\ --vimgrep\ $*   " substitute grep with ripgrep
endif
let general#project_root_makers = ['.root', '.pro', 'Cargo.toml', 'compile_commands.json', '.git']

call utils#ensure_dir_exist(general#backup_dir)
call utils#ensure_dir_exist(general#swap_dir)
call utils#ensure_dir_exist(general#undo_dir)
call utils#ensure_dir_exist(general#session_dir)
let &backupdir = general#backup_dir . '/'
let &directory = general#swap_dir . '/'
let &undodir = general#undo_dir . '/'
let g:session_directory = general#session_dir

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
let g:loaded_machit = 1
let loaded_matchparen = 1
let g:loaded_rrhelper = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:did_install_default_menus = 1

set path+=include
set updatetime=300
set fileformat=unix " Use UNIX line feed
set backspace=indent,eol,start " Ensure backspace is available
set mouse=a         " Enable mouse
set laststatus=2    " Always show status line
set number          " Show line number
set showtabline=2   " Always display tabline
set diffopt+=vertical,algorithm:histogram
set noerrorbells    " No beep
set vb t_vb=
set undofile        " Persist undo history
set backup          " Backup files
set backupskip+=COMMIT_EDITMSG " Don't backup git commit
set completeopt+=noselect " Don't select candidate automatically
set wildignore=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore+=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib,*.out
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=target
set wildignore+=node_modules
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
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
set lazyredraw      " Delay redraw event
set listchars=eol:¬,tab:>·,extends:>,precedes:<,space:␣ " Display special characters

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif

" Turn on true color
if has('nvim')
	set termguicolors
elseif has('termguicolors')
	" Fix bug for Vim
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
else
	set t_Co=256
endif

" Neovim gui
if has('gui_running')
    exec 'source' general#gvimrc
endif

" Use vim(fugitive) as git merge tool
if exists('g:merged')
    let g:diff_translations = 0
    let g:SignatureEnabledAtStartup = 0
    let b:coc_enabled = 0
    autocmd BufWinEnter * normal gg
    nnoremap <buffer> <nowait> <silent> gh :diffget //2<CR>]czz
    nnoremap <buffer> <nowait> <silent> gl :diffget //3<CR>]czz
    set syntax=diff
endif

"}}}
