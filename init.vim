" (Neo)vim configuration
" Last Change: 2020-11-28 
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

" general settings {{{
if &compatible
	set nocompatible
endif

let g:YCM_enabled = 0
let g:grepper = 'grep'
let g:findder = 'find'
if executable('fd')
	let g:findder = 'fd'
endif
if executable('rg')
	let g:grepper = 'rg'
    set grepprg=rg\ --ignore-case\ --vimgrep\ $*   " substitute grep with ripgrep
endif

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
set mouse=r
set foldmethod=marker
set laststatus=2    " always show status line
set number
set showtabline=2
set noerrorbells    " No beep
set undofile        " Persist undo history
set backup          " Backup files
set wildignore=*.o,*.obj,*.bin,*.img,*.lock,.git "Ignore files when expanding wildcards

call tools#ensure_dir_exist($HOME . '/.vim/.backup')
call tools#ensure_dir_exist($HOME . '/.vim/.swap')
call tools#ensure_dir_exist($HOME . '/.vim/.undo')
set backupdir=$HOME/.vim/.backup//
set directory=$HOME/.vim/.swap//
set undodir=$HOME/.vim/.undo//

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
if &shell =~? 'fish'
	set shellpipe=&>\ %s        
else
	set shellpipe=>\ %s\ 2>&1   
endif

" On Windows, use the Documents as default working directory
if has('win32')
    autocmd VimEnter * cd "$HOME\Documents"
endif

" Fullscreen
autocmd GUIEnter * simalt ~x
" Delete tool bar, menu bar and scroll bar
set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=R
set guioptions-=r
set guioptions-=l

" Set GUI font
if has('win32')
	set guifont=Source_Code_Pro:h9:cANSI:qDRAFT
elseif has('unix')
	set guifont="Source Code Pro 10"
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
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/bin/python3'

for keymap in  globpath(expand('~/.config/nvim'), 'keymap/*.vim', 0, 1)
    exec "source " . keymap
endfor
" }}}

" dein ----{{{
if has('unix')
    if empty(glob('~/.config/nvim/plugged'))
            silent !sh ~/.config/nvim/tools/dein.sh ~/.config/nvim/plugged
            autocmd VimEnter * call dein#install()
    endif
endif

" Substitute wget or curl with axel which is a multi-threaded downloader
if executable('axel')
	let g:dein#download_command = 'axel -n 4 -o'
endif

" Don't clone deeply
let g:dein#types#git#clone_depth = 1
" Don't show progress in message. I use lightline to show grogress.
let g:dein#install_progress_type = 'none'
set runtimepath+=~/.config/nvim/plugged/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.config/nvim/plugged')
	call dein#begin('~/.config/nvim/plugged')
	call dein#add('~/.config/nvim/plugged/repos/github.com/Shougo/dein.vim')
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')            " Automatically switch relative line number and absolute line number.
	" Vim enhacement
	call dein#add('rhysd/accelerated-jk')                         " Accelerate speed of key 'j' and 'k'
	call dein#add('bronson/vim-visual-star-search')               " Use * and # in visual mode
	call dein#add('tweekmonster/startuptime.vim', {
				\ 'lazy': 1,
				\ 'on_cmd': ['StartupTime']
				\ })                                              " Measure startup time
	call dein#add('ryanoasis/vim-devicons')                       " Show icons of some file types
	call dein#add('wincent/terminus')                             " Add some GUI feature for terminal Vim
	call dein#add('vim-utils/vim-man')                            " Read man page in Vim
	call dein#add('farmergreg/vim-lastplace')                     " Keep cursor to the same position where we exit session
	call dein#add('xolox/vim-misc')                               " Dependency of vim-session
	call dein#add('xolox/vim-session')                            " Save Vim session without pain

	" Text edit
	call dein#add('wellle/targets.vim')                           " Text objects
	call dein#add('haya14busa/is.vim')                            " Some enhancement of incsearch
	call dein#add('tommcdo/vim-exchange')                         " Exchange two words or lines
	call dein#add('SirVer/ultisnips', {
				\ 'on_if':"has('python3')",
				\ 'on_event': 'TextChangedI'
				\ })                                              " Code snippets engine
	call dein#add('preservim/nerdcommenter', {
				\ 'on_event': 'BufReadPost'
				\ })
	call dein#add('jiangmiao/auto-pairs')                         " Pairs matching/completion
	call dein#add('tpope/vim-repeat')                             " Repeat modification made by vim-commentary, vim-surround
	call dein#add('tpope/vim-unimpaired', {
				\ 'lazy': 1,
				\ 'on_event': 'BufReadPost'
				\ })                                              " Some shortcuts should be built in Vim
	call dein#add('junegunn/vim-easy-align')                      " Align code
	call dein#add('Yggdroot/indentLine', {'on_event': 'BufRead'}) " Indent indication
    call dein#add('Chiel92/vim-autoformat')                        
	call dein#add('https://gitee.com/kongjun18/vim-sandwich.git') " A fork of machakann/vim-sandwich, using vim-surround mapping
	call dein#add('machakann/vim-highlightedyank')                " Highlight yanked area
	" call dein#add('vim-scripts/fcitx.vim', {
	"             \ 'lazy': 1,
	"             \ 'on_event': 'InsertEnter'
	"             \ })
    call dein#add('lilydjwg/fcitx.vim', {
                  \ 'lazy': 1,
                  \ 'on_event': 'InsertEnter'
                  \ })
	" Leetcode
	call dein#add('ianding1/leetcode.vim', {
				\ 'lazy': 1,
				\ 'on_cmd': ['LeetCodeSignIn', 'LeetCodeList']
				\ })                                             " Practise leetcode in Vim

	" Vimwiki
	call dein#add('vimwiki/vimwiki', {
				\ 'lazy': 1,
				\ 'on_cmd': ['VimwikiIndex']
				\ })                                            " Personal wiki

	" Tag system
	call dein#add('vim-scripts/gtags.vim')                      " Integrate gtags(GNU Global) and Vim
	call dein#add('liuchengxu/vista.vim')                       " Show tags in sidebar 
	call dein#add('ludovicchabant/vim-gutentags')               " Generate tags automatically
	call dein#add('skywind3000/gutentags_plus')                 " Switch cscope automatically

	" debug
	call dein#add('puremourning/vimspector', {
				\ 'lazy': 1,
				\ 'on_ft': ['c', 'cpp', 'rust', 'python']
				\ })                                            " Debug adaptor of Vim

	" Git
	call dein#add('tpope/vim-fugitive', {
				\ 'lazy': 1,
				\ 'on_event': 'BufReadPost'
				\ })                                            " Git wrapper of Vim
	call dein#add('airblade/vim-gitgutter')                     " Show diff status

	" Status
	call dein#add('itchyny/lightline.vim')                      " Status line
	call dein#add('luochen1990/rainbow')                        " Give unmatched pairs different color 
	call dein#add('itchyny/vim-cursorword')                     " Underline the word of cursor
	call dein#add('lfv89/vim-interestingwords')                 " Highlight interesting word

	" Language-enhancement
    if tools#nvim_is_latest()
        call dein#add('nvim-treesitter/nvim-treesitter')        " A syntax highlight plugin
        call dein#disable('vim-toml')                           " A syntax file of toml 
        call dein#disable('vim-cpp-enhanced-hightlight')        " A syntax highlight plugin of C/C++
    else
        call dein#add('wsdjeg/vim-lua', {    
                    \ 'lazy': 1,
                    \ 'on_ft': 'lua'
                    \ })                                        " A syntax file of Lua
        call dein#add('elzr/vim-json', {
                    \ 'lazy': 1,
                    \ 'on_ft': 'json'
                    \ })                                        " A syntax file of json
        call dein#add('cespare/vim-toml', {
                    \ 'lazy': 1,
                    \ 'on_ft': 'toml'
                    \ })
        call dein#add('octol/vim-cpp-enhanced-highlight', {
                    \ 'lazy': 1,
                    \ 'on_ft': ['c', 'cpp']
                    \ })
        call dein#disable('nvim-treesitter')
    endif
	call dein#add('Townk/vim-qt', {
				\ 'lazy': 1,
				\ 'on_ft': 'cpp'
				\ })                                           " A syntax file of Qt 
	call dein#add('dag/vim-fish', {
				\ 'lazy': 1,
				\ 'on_ft': 'fish'
				\ })                                           " A syntax file of fish shell
	" Writing
    call dein#add('plasticboy/vim-markdown', {
                \ 'lazy': 1,
                \ 'on_ft': 'markdown'
                \ })                                           " Enhance the support of markdown
	call dein#add('iamcco/markdown-preview.nvim', {
				\ 'lazy': 1,
				\ 'on_ft': 'markdown'
				\ })                                           " Preview markdown in the browser
	call dein#add('mzlogin/vim-markdown-toc', {
				\ 'lazy': 1,
				\ 'on_ft': 'markdown'
				\ })                                           " Generate TOC of markdown 
	call dein#add('ferrine/md-img-paste.vim', {
				\ 'lazy': 1,
				\ 'on_ft': 'markdown'
				\ })                                           " Paste image in Vim
	call dein#add('reedes/vim-wordy', {
				\ 'lazy': 1,
				\ 'on_ft': ['markdown', 'vimwiki', 'text']
				\ })                                           " English check
	" VimL
	call dein#add('tpope/vim-scriptease', {
				\ 'lazy': 1,
				\ 'on_ft': 'vim'
				\ })                                           " Ease the development of vimscript

	" Color scheme
	call dein#add('KeitaNakamura/neodark.vim')
	call dein#add('laggardkernel/vim-one')
	call dein#add('morhetz/gruvbox')
	call dein#add('sainnhe/edge') 				               " Defualt color scheme

	" project management
	call dein#add('Yggdroot/LeaderF')                          " Fuzzy finder
	if (g:YCM_enabled)
        " using YCM and ALE
		call dein#add('https://gitee.com/mirrors/youcompleteme.git', {'build': 'python3 install.py --clangd-completer'})                          " code completion for C/C++, Java and Rust.
		call dein#add('dense-analysis/ale', {
					\ 'lazy': 1,
					\ 'on_ft': ['c', 'cpp', 'rust', 'python', 'asm', 'sh', 'fish', 'bash'],
					\ 'depends': 'lightline.vim'
					\ })
		call dein#disable('coc.nvim')
        call dein#disable('coc-clangd')
        call dein#disable('coc-rust-analyzer')
	else
        " using coc.nvim
		call dein#add('neoclide/coc.nvim', {
					\ 'rev': 'release',
					\ 'lazy': 1,
					\ 'on_event': 'BufReadPost'
					\ })
        call dein#add('clangd/coc-clangd', {
                    \ 'build': 'yarn install --frozen-lockfile',
                    \ 'depends': 'coc.nvim'
                    \ })
        call dein#add('fannheyward/coc-rust-analyzer', {
                    \ 'build': 'yarn install --frozen-lockfile',
                    \ 'depends': 'coc.nvim'
                    \ })
		call dein#disable('youcompleteme.git')
		call dein#disable('ale')
	endif
	call dein#add('vim-scripts/DoxygenToolkit.vim', {
				\ 'lazy': 1,
				\ 'on_ft': ['c', 'cpp', 'python']
				\ })                                             " Manage Doxygen
	call dein#add('tpope/vim-projectionist')                     " Switch between files
	call dein#add('skywind3000/asyncrun.vim')                    " Run shell command asynchronously
	call dein#add('skywind3000/asynctasks.vim')                  " Run tasks asynchronously
	call dein#add('Shougo/echodoc.vim', {
				\ 'lazy': 1,
				\ 'on_ft': ['c', 'cpp', 'python', 'rust']
				\ })                                            " Echo parameters of function

	" other
    call dein#add('yianwillis/vimcdoc')                         " Chinese version of vi mdoc
	call dein#add('voldikss/vim-translator')                    " Translator
	call dein#add('voldikss/vim-floaterm')                      " Popup terminal
	call dein#add('tpope/vim-eunuch', {'on_if': has('unix')})   " use UNIX command in Vim
	call dein#add('skywind3000/vim-quickui', {
				\ 'lazy': 1,
				\ 'on_if': "has('patch-8.1.2292') == 0 && exists('*nvim_open_win') == 0"
				\ })                                            " Simple menu bar of terminal Vim
	call dein#add('wakatime/vim-wakatime', {
				\ 'lazy': 1,
				\ 'on_event': 'BufReadPost'
				\ })                                            " Time statistics

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()                                         " Install plugins automatically
	call dein#install()
endif
filetype plugin indent on                                       " Use filetype-specific plugins
syntax on

" }}}

" color scheme {{{
set background=dark
colorscheme edge
" gruvbox
let g:gruvbox_contrast_dark = 'soft'
" edge
let g:edge_style = 'neon'
let g:edge_better_performance = 1
" }}}

"YouCompleteMe setting{{{
if g:YCM_enabled
	let g:ycm_auto_trigger = 1
	let g:ycm_add_preview_to_completeopt = 0
	let g:ycm_show_diagnostics_ui = 0
	let g:ycm_server_log_level = 'info'
	let g:ycm_min_num_identifier_candidate_chars = 2
	let g:ycm_collect_identifiers_from_comments_and_strings = 1
	let g:ycm_complete_in_strings=1
	let g:ycm_key_invoke_completion = '<c-z>'
	set completeopt=menu,menuone

	noremap <c-z> <NOP>

	let g:ycm_semantic_triggers =  {
				\ 'c,cpp,rust,java,bash': ['re!\w{2}'],
				\ 'lua': ['re!\w{2}'],
				\ }

	let g:ycm_filetype_whitelist = {
				\ "c":1,
				\ "cpp":1,
				\ "rust":1,
				\ "java":1,
				\ }

	let g:ycm_rust_src_path = '/home/kongjun/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
    let g:ycm_clangd_binary_path = exepath('clangd')
	" 禁止自动添加头文件
	" 详细的补全建议
	let g:ycm_clangd_args = [ '--header-insertion=never', '--completion-style=detailed']

	let g:ycm_confirm_extra_conf = 0
endif
"}}}

" ale {{{
if g:YCM_enabled
	let g:ale_enabled = 0
	let g:ale_c_parse_compile_commands = 1
	let g:ale_lint_on_text_changed = 'normal'
	let g:ale_lint_on_insert_leave = 1
	let g:ale_lint_on_save = 1

	let g:ale_linters_explicit = 1
	let g:ale_linters = {
				\ 'asm': ['gcc'],
				\ 'c': ['gcc', 'cppcheck'],
				\ 'cpp': ['gcc', 'cppcheck'],
				\ 'rust': ['cargo', 'rls'],
				\ 'sh': ['shellcheck', 'sh'],
				\ 'fish': ['fish']
				\}
	" let g:ale_c_cc_executable='gcc'
	" let g:ale_cpp_cc_executable='g++'
	" " "  -Wall will open option -Wconversion.
	" " "  -Wextra will open option -Wsign-compare
	" " "  -Wconversion open -Wsign-conversion defaultly.
	" let g:ale_c_cc_options = '-Wall -Wextra -Wfloat-equal -Winline -Wduplicated-branches -Wduplicated-cond -Wunused -std=gnu11'
	" " "  -Wconversion don't open -Wsign-conversion for C++
	" " "  I use ISO C++, so open -pedantic-errors to find behaviors which break the standard.
	" let g:ale_cpp_cc_options = '-pedantic-errors -Wall -Wextra -Wsign-conversion -Wfloat-equal -Winline -Wduplicated-branches -Wduplicated-cond -Wunused -std=c++20'
	"
	" let g:ale_c_cppcheck_options = '--enable=all --suppress=missingIncludeSystem --std=c11'
	" let g:ale_cpp_cppcheck_options = '--enable=all --suppress=missingIncludeSystem --std=c++2a'

	" 使用 quickfix 会与 gtags-scope 重叠，所以使用 location list
	let g:ale_set_quickfix = 0
	let g:ale_set_loclist = 1
	let g:ale_open_list = 0

	" 使用 compile_commands.json，在项目目录中查找

	" key-mapping
	nnoremap gn :ALENext<CR>
	nnoremap gN :ALEPrevious<CR>


	" 修改错误标志
	let g:ale_sign_error = "✖"
	let g:ale_sign_warning = "‼"
	" ➤
	let g:ale_sign_info = "ℹ"
	hi! clear SpellBad
	hi! clear SpellCap
	hi! clear SpellRare
	hi! SpellBad gui=undercurl guisp=red
	hi! SpellRare gui=undercurl guisp=magenta
	hi! SpellCap gui=undercurl guisp=blue
	function! MyOnBattery()
		return !filereadable('/sys/class/power_supply/AC/online') || readfile('/sys/class/power_supply/AC/online') == ['0']
	endfunction
	if MyOnBattery()
		let g:ale_completion_delay = 500
		let g:ale_echo_delay = 20
		let g:ale_lint_delay = 500
	endif
endif


" }}}

" echodoc setting{{{
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = "floating"
highlight link EchoDocFloat Pmenu"}}}

"cpp-enhanced-highlight setting{{{

let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let c_no_curly_error=1

"}}}

"rainbow{{{
let g:rainbow_active = 1 "0 if you want to enable it later via :rainbowtoggle
let g:rainbow_conf = {
			\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
			\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
			\   'operators': '_,_',
			\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
			\   'separately': {
			\       '*': {},
			\       'tex': {
			\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
			\       },
			\       'lisp': {
			\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
			\       },
			\       'vim': {
			\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimfuncbody', 'start=/\[/ end=/\]/ containedin=vimfuncbody', 'start=/{/ end=/}/ fold containedin=vimfuncbody'],
			\       },
			\       'html': {
			\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-za-z0-9]+)(\s+[-_:a-za-z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
			\       },
			\       'css': 0,
			\   }
			\}"}}}

" LeaderF{{{

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PopupHeight = 0.3
let g:Lf_DefaultExternalTool = g:findder
if g:findder == 'fd'
    let g:Lf_ExternalCommand = 'fd -E _builds --type f "%s"'           " On MacOSX/Linux
endif
let g:Lf_PreviewCode = 1
let g:Lf_PreviewResult = {
			\ 'File': 0,
			\ 'Buffer': 0,
			\ 'Mru': 0,
			\ 'Tag': 1,
			\ 'BufTag': 1,
			\ 'Function': 1,
			\ 'Line': 0,
			\ 'Colorscheme': 0,
			\ 'Rg': 1,
			\ 'Gtags': 1
			\}
" let g:Lf_GtagsAutoGenerate = 0
" let g:Lf_GtagsGutentags = 1
" let g:Lf_Gtagslabel = 'native-pygments'
" let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_RootMarkers = ['.root', '.git', '.pro', 'Cargo.toml']   " 设置项目根目录标记
let g:Lf_WorkingDirectoryMode = 'A'                " 设置 LeaderF 工作目录为项目根目录，如果不在项目中，则为当前目录。
let g:Lf_ShortcutF = "<Leader>lf"
let g:Lf_ShortcutB = "<Leader>lb"
nnoremap <Leader>lp :LeaderfFunction<CR>
nnoremap <Leader>ll :LeaderfBufTagAll<CR>
nnoremap <Leader>ld :LeaderfTag<CR>
nnoremap <leader>lh :LeaderfHelp<CR>
nnoremap <Leader>lr :Leaderf rg<Space><Right>
nnoremap <leader>lt :Leaderf task<CR>
"}}}

" tag system ------------{{{

"       gutentags ----------------{{{

" for debug
" let g:gutentags_define_advanced_commands = 1
" let g:gutentags_trace = 1

let g:gutentags_exclude_filetypes = ['text', 'markdown', 'cmake', 'snippets', 'vimwiki', 'dosini', 'gitcommit', 'git', 'json', 'help', 'html', 'javascript']
" 开启拓展支持
let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.git', '.pro', 'Cargo.toml', 'compile_commands.json']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tag'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	set csprg=gtags-cscope
	let g:gutentags_modules += ['gtags_cscope']
endif

" 尽量使用universial-ctags，vista.vim不支持exuberant-ctags。
" CentOS上可以使用snap安装。

" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args = ['--fields=+niazS']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--exclude=_builds']
let g:gutentags_ctags_extra_args += ['--exclude=doc']
let g:gutentags_ctags_extra_args += ['--exclude=plugged']


" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 将自动生成的gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
if has('win32')
	let g:gutentags_cache_dir = expand("C:Users\\kongjun\\Documents\\.cache\\tags")
	let g:gutentags_gtags_dbpath ="C:Users\\kongjunDocuments\\.cache\\tags"
elseif has('unix')
	let g:gutentags_cache_dir = expand('~/.cache/tags')
endif

" 自动加载gtags_cscope数据库
let g:gutentags_auto_add_gtags_cscope = 0
" }}}

"       gutentags_plus ------------{{{

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 0
let g:gutentags_plus_nomap = 1


if g:YCM_enabled
	nnoremap <silent> gs :GscopeFind s <C-R><C-W><cr>:cnext<CR>zz
	nnoremap <silent> gc :GscopeFind c <C-R><C-W><cr>:cnext<CR>zz
	nnoremap <silent> gt :GscopeFind t <C-R><C-W><cr>:cnext<CR>zz
	nnoremap <silent> ge :GscopeFind e <C-R><C-W><cr>:cnext<CR>zz
	nnoremap <silent> gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
	nnoremap <silent> gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
	nnoremap <silent> gC :GscopeFind d <C-R><C-W><cr>:cnext<CR>zz
	nnoremap <silent> ga :GscopeFind a <C-R><C-W><cr>:cnext<CR>zz
	nnoremap <silent> gd :GscopeFind g <C-R><C-W><cr>:cnext<CR>zz
endif
" --------------}}}

" gtags(global) {{{
noremap <C-g> mG:GtagsCursor<CR>zz"}}}

" vista{{{

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
let g:vista#extensions = ['vimwiki']
noremap [ov :Vista<CR>
noremap ]ov :Vista!<CR>
noremap yov :Vista!!<CR>
"}}}

" -----------}}}

" indentLine{{{

let g:indentLine_enabled = 1
let g:indentLine_conceallevel = 2
let g:indentLine_char_list = ['|', '¦', '┆', '┊']"}}}

" AutoFormat{{{

" use clang-format as default formatter
" use mozilla style as default C/C++ style
let g:formatdef_my_custom_c = '"clang-format --style=\"{BasedOnStyle: mozilla, IndentWidth: 4}\""'
let g:formatters_c = ['my_custom_c']
let g:formatters_cpp = ['my_custom_c']

" use lua-format as default lua formatter
let g:formatdef_my_custom_lua = 'lua-format -i'
let g:formatter_lua = ['my_custom_lua']
nnoremap <Leader>bf :Autoformat<CR>
"}}}

" autopairs{{{

let g:AutoPairsShortcutToggle = ''          " disable shortcut
" enable fly-mode
let g:AutoPairsFlyMode = 0                  " disable fly mode
"}}}

" vim-floaterm{{{

let g:floaterm_keymap_toggle = '[ot'
let g:floaterm_keymap_hide   = ']ot'
let g:floaterm_keymap_prev   = '[t'
let g:floaterm_keymap_next   = ']t'

"}}}

" Ultisnippet{{{
"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"}}}

" vim-quickui{{{

if has('patch-8.1.2292') == 0 && exists('*nvim_open_win') == 0
	echoerr "vim-quickui can't work"
else
	autocmd VimEnter * call quickui#menu#reset()

	autocmd VimEnter * call quickui#menu#install('&Build', [
				\ [ "Build &File", 'AsyncTask file-build' ],
				\ [ "Run &File", 'AsyncTask file-run' ],
				\ [ "Build &Project", 'AsyncTask project-build' ],
				\ [ "Run &Project", 'AsyncTask project-run' ],
				\ [ "Run &Test", 'AsyncTask file-test' ]
				\ ])
	autocmd VimEnter * call quickui#menu#install('&Symbol', [
				\ [ "Find &Definition\t(GNU Global)", 'autocmd VimEnter * call MenuHelp_Gscope("g")', 'GNU Global search g'],
				\ [ "Find &Symbol\t(GNU Global)", 'call MenuHelp_Gscope("s")', 'GNU Gloal search s'],
				\ [ "Find &Called by\t(GNU Global)", 'call MenuHelp_Gscope("d")', 'GNU Global search d'],
				\ [ "Find C&alling\t(GNU Global)", 'call MenuHelp_Gscope("c")', 'GNU Global search c'],
				\ [ "Find &From Ctags\t(GNU Global)", 'call MenuHelp_Gscope("z")', 'GNU Global search c'],
				\ [ "--", ],
				\ [ "Goto D&efinition\t(YCM)", 'YcmCompleter GoToDefinitionElseDeclaration'],
				\ [ "Goto &References\t(YCM)", 'YcmCompleter GoToReferences'],
				\ [ "Get D&oc\t(YCM)", 'YcmCompleter GetDoc'],
				\ [ "Get &Type\t(YCM)", 'YcmCompleter GetTypeImprecise'],
				\ ])
	" call quickui#menu#install('&Tools', [
	"           \ ['List &Buffer', 'call quickui#tools#list_buffer("e")', ],
	"           \ ['List &Function', 'call quickui#tools#list_function()', ],
	"           \ ['--',''],
	"           \ ['&Spell %{&spell? "Disable":"Enable"}', 'set spell!', 'Toggle spell check %{&spell? "off" : "on"}'],
	"           \ ])

	autocmd VimEnter * call quickui#menu#install('&Vimwiki', [
				\ ["&Vimwiki2HTMLBrowse", "Vimwiki2HTMLBrowse", "Convert Vimwiki to HTML and browse it"],
				\ ['&VimwikiTOC', "VimwikiTOC", "Generate TOC"]
				\ ])

	autocmd VimEnter * call quickui#menu#install('&Plugin', [
				\ ["Plugin &Snapshot", "PlugSnapshot", "Update snapshort"],
				\ ["Plugin &Update", "PlugUpdate", "Update plugin"],
				\ ["Plugin &upgrade", "PlugUpgrade", "Upgrade plugin manager"],
				\ ["Plugin &Install", "PlugInstall", "Install plugin"],
				\ ["Plugin &Clean", "PlugClean", "Clean plugin"]
				\ ])


	autocmd VimEnter * call quickui#menu#install('Help (&?)', [
				\ ["&Index", 'tab help index', ''],
				\ ['Ti&ps', 'tab help tips', ''],
				\ ['--',''],
				\ ["&Tutorial", 'tab help tutor', ''],
				\ ['&Quick Reference', 'tab help quickref', ''],
				\ ['&Summary', 'tab help summary', ''],
				\ ['--',''],
				\ ['&Vim Script', 'tab help eval', ''],
				\ ['&Function List', 'tab help function-list', ''],
				\ ], 10000)

	let g:quickui_show_tip = 1


	"----------------------------------------------------------------------
	" context menu
	"----------------------------------------------------------------------
	let g:context_menu_k = [
				\ ["&Peek Definition\tAlt+;", 'call quickui#tools#preview_tag("")'],
				\ ["S&earch in Project\t\\cx", 'exec "silent! GrepCode! " . expand("<cword>")'],
				\ [ "--", ],
				\ [ "Find &Definition\t\\cg", 'call MenuHelp_Fscope("g")', 'GNU Global search g'],
				\ [ "Find &Symbol\t\\cs", 'call MenuHelp_Fscope("s")', 'GNU Gloal search s'],
				\ [ "Find &Called by\t\\cd", 'call MenuHelp_Fscope("d")', 'GNU Global search d'],
				\ [ "Find C&alling\t\\cc", 'call MenuHelp_Fscope("c")', 'GNU Global search c'],
				\ [ "Find &From Ctags\t\\cz", 'call MenuHelp_Fscope("z")', 'GNU Global search c'],
				\ [ "--", ],
				\ [ "Goto D&efinition\t(YCM)", 'YcmCompleter GoToDefinitionElseDeclaration'],
				\ [ "Goto &References\t(YCM)", 'YcmCompleter GoToReferences'],
				\ [ "Get D&oc\t(YCM)", 'YcmCompleter GetDoc'],
				\ [ "Get &Type\t(YCM)", 'YcmCompleter GetTypeImprecise'],
				\ [ "--", ],
				\ ['Dash &Help', 'call asclib#utils#dash_ft(&ft, expand("<cword>"))'],
				\ ['Cpp&man', 'exec "Cppman " . expand("<cword>")', '', 'c,cpp'],
				\ ['P&ython Doc', 'call quickui#tools#python_help("")', 'python'],
				\ ]

	" 定义按两次空格就打开上面的目录
	noremap  <localleader>m :call quickui#menu#open()<cr>
	nnoremap <localleader>p :call quickui#tools#preview_tag('')<cr>
	nnoremap <localleader>j :call quickui#preview#scroll(5)<cr>
	nnoremap <localleader>k :call quickui#preview#scroll(-5)<cr>
	augroup MyQuickfixPreview
		au!
		au FileType qf noremap <silent><buffer> p :call quickui#tools#preview_quickfix()<cr>
	augroup END
endif
"}}}

"       Asyncrun and Asynctask{{{
" integrate LeaderF and Asynctask
function! s:lf_task_source(...)
	let rows = asynctasks#source(&columns * 48 / 100)
	let source = []
	for row in rows
		let name = row[0]
		let source += [name . '  ' . row[1] . '  : ' . row[2]]
	endfor
	return source
endfunction


function! s:lf_task_accept(line, arg)
	let pos = stridx(a:line, '<')
	if pos < 0
		return
	endif
	let name = strpart(a:line, 0, pos)
	let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
	if name != ''
		exec "AsyncTask " . name
	endif
endfunction

function! s:lf_task_digest(line, mode)
	let pos = stridx(a:line, '<')
	if pos < 0
		return [a:line, 0]
	endif
	let name = strpart(a:line, 0, pos)
	return [name, 0]
endfunction

function! s:lf_win_init(...)
	setlocal nonumber
	setlocal nowrap
endfunction


let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
let g:Lf_Extensions.task = {
			\ 'source': string(function('s:lf_task_source'))[10:-3],
			\ 'accept': string(function('s:lf_task_accept'))[10:-3],
			\ 'get_digest': string(function('s:lf_task_digest'))[10:-3],
			\ 'highlights_def': {
			\     'Lf_hl_funcScope': '^\S\+',
			\     'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
			\ },
		\ }
" integrate fugitive and Asyncrun
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
" edit tasks.init
command! TaskEdit vsp ~/.config/nvim/tasks.ini

let g:asynctasks_term_pos = 'tab'

" 自动打开 quickfix window ，高度为 10
let g:asyncrun_open = 10

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置项目根
let g:asyncrun_rootmarks = ['.root', '.git', '.pro', 'Cargo.toml']

let g:asynctasks_term_rows = 20    " 设置纵向切割时，高度为 10
let g:asynctasks_term_cols = 80    " 设置横向切割时，宽度为 80

" " 编译、运行
nnoremap  <Leader>fb :AsyncTask file-build<cr>
nnoremap  <Leader>fr :AsyncTask file-run<cr>
nnoremap  <Leader>ft :Asynctask file-test<cr>
nnoremap  <leader>pg :AsyncTask project-configurate<CR>
nnoremap  <Leader>pb :AsyncTask project-build<CR>
nnoremap  <Leader>pr :AsyncTask project-run<CR>
nnoremap  <Leader>pc :AsyncTask project-clean<CR>
nnoremap  <Leader>pt :Asynctask project-test<CR>
"}}}

"              vim-translator{{{

let g:translator_default_engines = ['google', 'bing', 'youdao']
let g:translator_history_enable = 1

nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>tw <Plug>TranslateW
vmap <silent> <Leader>tw <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <Leader>tr <Plug>TranslateR
vmap <silent> <Leader>tr <Plug>TranslateRV
" Translate the text in clipboard
nmap <silent> <Leader>tx <Plug>TranslateX"}}}

" plugin shortcut{{{

function <SID>PluginClean()
	let unused_plugin_dir = dein#check_clean()
	if len(unused_plugin_dir) == 0
		echomsg "There is no unused plugin"
        return 
	endif
	for dir in unused_plugin_dir
		try
			call delete(dir, 'rf')
		catch /.*/
			echoerr "remove unused plugin directory failed"
		endtry
		echomsg "removed unused plugin directory"
	endfor
endfunction

function <SID>PluginRecache()
	try
		call dein#clear_state()
		call dein#recache_runtimepath()
	catch /.*/
		echoerr "Error in <SID>PluginRecache"
    endtry
endfunction
command! -nargs=0 PlugInstall call dein#install()
command! -nargs=0 PlugUpdate call dein#update()
command! -nargs=0 PlugClean call <SID>PluginClean()
command! -nargs=0 PlugRecache call <SID>PluginRecache()
" }}}

	" coc.nvim{{{
	if !g:YCM_enabled
		hi! CocErrorSign guifg=#d1666a
		let g:coc_status_error_sign = "✖ "
		let g:coc_status_warning_sign = "‼ "

		" Use tab for trigger completion with characters ahead and navigate.
		" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
		" other plugin before putting this into your config.
		inoremap <silent><expr> <TAB>
					\ pumvisible() ? "\<C-n>" :
					\ <SID>check_back_space() ? "\<TAB>" :
					\ coc#refresh()
		inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

		function! s:check_back_space() abort
			let col = col('.') - 1
			return !col || getline('.')[col - 1]  =~# '\s'
		endfunction

		nmap <silent> gN <Plug>(coc-diagnostic-prev)
		nmap <silent> gn <Plug>(coc-diagnostic-next)


		" GoTo code navigation.
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> gr <Plug>(coc-references)


		" Use K to show documentation in preview window.
		nnoremap <silent> gK :call <SID>show_documentation()<CR>

		function! s:show_documentation()
			if (index(['vim','help'], &filetype) >= 0)
				execute 'h '.expand('<cword>')
			elseif (coc#rpc#ready())
				call CocActionAsync('doHover')
			else
				execute '!' . &keywordprg . " " . expand('<cword>')
			endif
		endfunction

		" Symbol renaming.
		nmap <leader>rv <Plug>(coc-rename)

		" Map function and class text objects
		" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
		xmap if <Plug>(coc-funcobj-i)
		omap if <Plug>(coc-funcobj-i)
		xmap af <Plug>(coc-funcobj-a)
		omap af <Plug>(coc-funcobj-a)
		xmap ic <Plug>(coc-classobj-i)
		omap ic <Plug>(coc-classobj-i)
		xmap ac <Plug>(coc-classobj-a)
		omap ac <Plug>(coc-classobj-a)


		" Remap <C-f> and <C-b> for scroll float windows/popups.
		" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
		nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
		nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
		inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
		inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

		" NeoVim-only mapping for visual mode scroll
		" Useful on signatureHelp after jump placeholder of snippet expansion
		if has('nvim')
			vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
			vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
		endif

		" Add `:Fold` command to fold current buffer.
		command! -nargs=? Fold :call     CocAction('fold', <f-args>)

		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	endif
	" }}}

	" netrw{{{

	let g:netrw_liststyle = 3
	let g:netrw_banner = 0
	let g:netrw_winsize = 25
	let g:netrw_sort_by = 'time'
	let g:netrw_srot_direction = 'reverse'
	let g:netrw_browse_split = 2"}}}

	" leetcode{{{

	let g:leetcode_solution_filetype = ['c', 'cpp', 'rust']
	let g:leetcode_browser = 'firefox'
	let g:leetcode_china = 1
	"}}}

	"  lightline -{{{
	if g:YCM_enabled
		let g:lightline = {
					\ 'colorscheme': 'edge',
					\ 'active': {
					\   'left': [['mode', 'paste'], ['filename', 'modified'], ['gitbranch', 'gutentags', 'dein']],
					\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
					\ },
					\ 'component_function': {
					\   'linter_warnings': 'LightlineLinterWarnings',
					\   'linter_errors': 'LightlineLinterErrors',
					\   'linter_ok': 'LightlineLinterOK',
					\   'gutentags': 'gutentags#statusline',
					\   'gitbranch': 'FugitiveHead',
					\   'dein': 'dein#get_progress'
					\ },
					\ 'component_type': {
					\   'readonly': 'error',
					\   'linter_warnings': 'warning',
					\   'linter_errors': 'error',
					\   'linter_ok': 'ok'
					\ },
					\ }
		autocmd User ALELint call lightline#update()
	else
		let g:lightline = {
					\ 'colorscheme': 'edge',
					\ 'active': {
					\   'left': [['mode', 'paste'], ['filename', 'modified'], ['gitbranch', 'gutentags', 'dein']],
					\   'right': [['lineinfo'], ['percent'], ['readonly'], ['cocstatus']]
					\ },
					\ 'component_function': {
					\   'gutentags': 'gutentags#statusline',
					\   'gitbranch': 'FugitiveHead',
					\   'cocstatus': 'coc#status',
					\   'dein': 'dein#get_progress'
					\ },
					\ 'component_type': {
					\   'readonly': 'error',
					\ },
					\ }
		autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
	endif
	autocmd User GutentagsUpdated,GutentagsUpdating call lightline#update()



	" }}}

	" vim-mam{{{
	nnoremap <Leader>hm :Vman 2 <C-r><C-w><CR>
	nnoremap <Leader>hh :vertical help <C-r><C-w><CR>
	"}}}

	" vimspector setting{{{
	let g:vimspector_enable_mappings = 'HUMAN'
	"}}}

	" vimwiki{{{

	let g:vimwiki_use_mouse = 1
	let wiki = {}
	let wiki.path =  '~/.vimwiki'
	let wiki.path_html= '~/.vimwiki/html'
	let wiki.html_header= '~/.vimwiki/tepmlate/header.tpl'
	let wiki.auto_tags= 1
	let wiki.nested_syntaxes = {'py': 'python', 'cpp': 'cpp', 'c': 'c', 'rs': 'rust', 'sh': 'bash', 'cmake': 'cmake', 'lua': 'lua'}
	let g:vimwiki_list = [wiki]
	nnoremap <Leader>vi :VimwikiIndex<CR>
	nnoremap <Leader>vt :VimwikiTOC<CR>
    nnoremap <Leader>vnl <Plug>VimwikiNextLink
	" remap gl<Space> and gL<Space>: remove checkbox
	nmap glt <Plug>VimwikiRemoveSingleCB
	nmap gLt <Plug>VimwikiRemoveCBInList
	" remap <C-Space>:
	nmap zv <Plug>VimwikiToggleListItem
    "}}}

	" vim-markdown {{{
	let g:markdown_fenced_languages = ['c', 'cpp', 'rust', 'python', 'sh', 'bash', 'fish']
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_strikethrough = 1

	" }}}

	" md paste {{{
    " all pictures reside on ./images/
	let g:mdip_imdir_intext = "./images"
    " when user don't provide picture name, use default name
	nmap <buffer><silent> <Leader>mp :call mdip#MarkdownClipboardImage()<CR>
	" --------}}}

	" vim-session{{{

	let g:session_autosave = 'no'
	let g:session_autoload = 'no'
	call tools#ensure_dir_exist($HOME . '/.vim/.session')
	let g:session_directory = "~/.vim/.session"
	"}}}

	" nerdcommmenter ---{{{

	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 1

	" Align line-wise comment delimiters both sides
    let g:NERDDefaultAlign = 'both'

	" Allow commenting and inverting empty lines (useful when commenting a region)
	let g:NERDCommentEmptyLines = 1

	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1

	" Enable NERDCommenterToggle to check all selected lines is commented or not
	let g:NERDToggleCheckAllLines = 1
	" }}}

" abbreviation{{{
iabbrev rn return
iabbrev today <C-r>=strftime("%Y-%m-%d")<CR>
" }}}

" nvim-treesitter {{{
if tools#nvim_is_latest()
lua << EOF
    require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "rust", "bash", "toml", "json", "yaml", "lua"},
    highlight = {
    enable = true,
    },
    indent = {
    enable = flase,
    }
    }
EOF
endif

" }}}
