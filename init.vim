" (Neo)vim configuration 
" Last Change: 2020-10-31 
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

" functions ---{{{

" if @dir exists, just exit.
" if @dir not exists, create it
function! EnsureDirExists(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction

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

function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ▲', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '✓' : ''
endfunction



" }}}

" general setting ---- {{{

if &compatible
    set nocompatible
endif

let s:grepper = 'grep'
let s:findder = 'find'
if executable('fd')
    let s:findder = 'fd'
endif
if executable('rg')
    let s:grepper = 'rg'
endif

" leader
let mapleader=' '
let maplocalleader='z'


set path+=include
set updatetime=100
set foldmethod=marker
set laststatus=2    " always show status line
set number
set showtabline=2
set noerrorbells    " 在错误时发出蜂鸣声
set visualbell      " 错误时出现视觉提示
set undofile    " 保存撤销历史
set backup
set writebackup " 删除旧备份，备份当前文件

call EnsureDirExists($HOME . '/.vim/backup')
call EnsureDirExists($HOME . '/.vim/swap')
call EnsureDirExists($HOME . '/.vim/undo')
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//

set hlsearch    " 模式查找高亮
set incsearch   " 增量查找
set wrapscan    " 在遇到文件结尾后从头查找
set nopaste     " 希望设置为 paste，但是设置为 paste 后似乎导致一些插件异常，所以在需要从外部粘贴时再手动开启
set ignorecase
set ttimeoutlen=100
set timeoutlen=1300
set encoding=utf-8
set termencoding=utf-8
set smartindent
set cursorline       " 特殊显示光标所在行
set nowrap
set linebreak       " 禁止在单词内部折行
set showmatch       " 搜索时高亮匹配的括号
set expandtab       " tab 自动转为空格
set tabstop=4      "set a tab equal to four space
set shiftwidth=4
set noshowmode      "use lightline
set showcmd
set showmatch
set noautochdir         " Rust 的 quickfix 设置有问题，无法正确地记录目录栈，所以禁止自动切换目录，只在根目录打开文件，确保 quickfix 可以正确跳转。详见:h quickfix-directory-stack
set wildmenu        "command complement
set wildmode=full
set shortmess+=c    " 去除选择补全时左下角"匹配 x / N"的提示

if &shell =~? 'fish'
    set shellpipe=&>\ %s          " fish shell
else
    set shellpipe=>\ %s\ 2>&1   " 用来压缩调用外部命令（比如make、grep）时的输出
endif

if has('win32')
    autocmd VimEnter * cd C:\Users\kongjun\Documents
endif

set grepprg=rg\ --ignore-case\ --vimgrep\ $*   " grep 使用 rg

" gvim自动全屏，并且去除工具栏、菜单栏、滚动栏。
autocmd GUIEnter * simalt ~x
set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=R
set guioptions-=r
set guioptions-=l

" guifont
if has('win32')
    set guifont=Source_Code_Pro:h9:cANSI:qDRAFT
elseif has('unix')
    set guifont="Source Code Pro 10"
endif

" turn on true color
if has('nvim')
    " enable true color
    set termguicolors
elseif has('termguicolors')
    " fix bug for Vim 
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    " enable true color
    set termguicolors
else
    " 8-bit color
    set t_Co=256
endif

set background=dark
colorscheme one

" --- }}}

" dein ----{{{
if has('unix')
    if empty(glob('~/.config/nvim/plugged'))
            silent !curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
            silent !sh ./installer.sh ~/.config/nvim/plugged
            autocmd VimEnter * call dein#install()
    endif
endif
let loaded_matchit = 1

set runtimepath+=~/.config/nvim/plugged/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.config/nvim/plugged')
    call dein#begin('~/.config/nvim/plugged')
    call dein#add('~/.config/nvim/plugged/repos/github.com/Shougo/dein.vim')
    " Vim enhacement
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')            " automatically switch relative line number and absulute line number.
    call dein#add('rhysd/accelerated-jk')                         " accelerate speed of key 'j' and 'k'
    call dein#add('bronson/vim-visual-star-search')               " use * and # in visual mod
    call dein#add('tweekmonster/startuptime.vim', {
                \ 'lazy': 1,
                \ 'on_cmd': ['StartupTime']
                \ })                 " measure startup time
    " Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    call dein#add('easymotion/vim-easymotion', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('wsdjeg/FlyGrep.vim')
    call dein#add('drmikehenry/vim-fixkey')                       " use ALT in Vim
    call dein#add('ryanoasis/vim-devicons')                       " show icons of some file types
    call dein#add('wincent/terminus')                             " add some GUI feature for terminal Vim
    call dein#add('vim-utils/vim-man')                            " read man page in Vim
    call dein#add('farmergreg/vim-lastplace')                     " keep cursor to the same positon where we exit session
    call dein#add('xolox/vim-misc')                               " dependency of vim-session
    call dein#add('xolox/vim-session')                            " save Vim session without pain

    " text edit
    call dein#add('wellle/targets.vim')                           " text objects
    call dein#add('haya14busa/is.vim')                            " some enhancement of incsearch
    call dein#add('matze/vim-move')                               " move text block in visual mode
    call dein#add('tommcdo/vim-exchange')                         " exchange two words or lines
    call dein#add('SirVer/ultisnips', {
                \ 'on_if':"has('python3')",
                \ 'on_event': 'TextChangedI'
                \ })                            " code snippets engine
    call dein#add('preservim/nerdcommenter', {
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('jiangmiao/auto-pairs')                         " pairs matching/completion
    call dein#add('tpope/vim-repeat')                             " repeat modification made by vim-commentary, vim-surround
    call dein#add('tpope/vim-unimpaired', {
                \ 'lazy': 1, 
                \ 'on_event': 'BufReadPost'
                \ })                         " some shortcut should be built in Vim
    call dein#add('junegunn/vim-easy-align')                      " align code
    call dein#add('Yggdroot/indentLine', {'on_event': 'BufRead'})    " indent indication
    call dein#add('Chiel92/vim-autoformat', {
                \ 'lazy': 1,
                \ 'on_ft': ['c', 'cpp', 'rust', 'python']
                \ })                       " wrapper of code formater
    call dein#add('https://gitee.com/kongjun18/vim-sandwich.git') " a fork of machakann/vim-sandwich, using vim-surround mapping
    call dein#add('machakann/vim-highlightedyank')                " highlight yanked area
    call dein#add('vim-scripts/fcitx.vim', {
                \ 'lazy': 1,
                \ 'on_event': 'InsertEnter'
                \ })
    " leetcode
    call dein#add('ianding1/leetcode.vim', {
                \ 'lazy': 1,
                \ 'on_cmd': ['LeetCodeSignIn', 'LeetCodeList'] 
                \ })                        " practise leetcode in Vim

    " vimwiki
    call dein#add('vimwiki/vimwiki')                              " personal wiki
    call dein#add('mattn/calendar-vim')                           " calendar

    " tag system
    call dein#add('vim-scripts/gtags.vim')
    call dein#add('liuchengxu/vista.vim')
    call dein#add('ludovicchabant/vim-gutentags')
    call dein#add('skywind3000/gutentags_plus')

    " debug
    call dein#add('puremourning/vimspector', {
                \ 'lazy': 1,
                \ 'on_ft': ['c', 'cpp', 'rust', 'python']
                \ })

    " Git
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-rhubarb')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('junegunn/gv.vim')

    " status
    call dein#add('itchyny/lightline.vim')
    call dein#add('edkolev/tmuxline.vim')
    call dein#add('luochen1990/rainbow')
    call dein#add('itchyny/vim-cursorword')   " underline the word of cursor
    call dein#add('lfv89/vim-interestingwords') " highlight word

    " language-enhancement
    call dein#add('Townk/vim-qt', {
                \ 'lazy': 1,
                \ 'on_ft': 'cpp'
                \ })
    call dein#add('wsdjeg/vim-lua', {    
                \ 'lazy': 1,
                \ 'on_ft': 'lua'
                \ })     
    call dein#add('dag/vim-fish', {
                \ 'lazy': 1,
                \ 'on_ft': 'fish'
                \ })
    call dein#add('cespare/vim-toml', {
                \ 'lazy': 1,
                \ 'on_ft': 'toml'
                \ })
    call dein#add('octol/vim-cpp-enhanced-highlight', {
                \ 'lazy': 1,
                \ 'on_ft': ['c', 'cpp']
                \ }) "cpp hightlight

    " writing
    call dein#add('tpope/vim-markdown', {
                \ 'lazy': 1,
                \ 'on_ft': 'markdown'
                \ }) 
    call dein#add('iamcco/markdown-preview.nvim', {
                \ 'lazy': 1,
                \ 'on_ft': 'markdown'
                \ })
    call dein#add('mzlogin/vim-markdown-toc', {
                \ 'lazy': 1,
                \ 'on_ft': 'markdown'
                \ })
    call dein#add('ferrine/md-img-paste.vim', {
                \ 'lazy': 1,
                \ 'on_ft': 'markdown'
                \ })
    call dein#add('reedes/vim-wordy', {
                \ 'lazy': 1,
                \ 'on_ft': ['markdown', 'vimwiki', 'text']
                \ })
    " vimL
    call dein#add('tpope/vim-scriptease', { 
                \ 'lazy': 1,
                \ 'on_ft': 'vim'
                \ })             

    " color scheme
    call dein#add('KeitaNakamura/neodark.vim')
    call dein#add('laggardkernel/vim-one')
    call dein#add('YorickPeterse/happy_hacking.vim')


    " project management
    call dein#add('Yggdroot/LeaderF')                 " fuzzy find
    call dein#add('vim-scripts/DoxygenToolkit.vim', {
                \ 'lazy': 1,
                \ 'on_ft': ['c', 'cpp', 'python']
                \ })   " manage Doxygen
    call dein#add('tpope/vim-projectionist')
    call dein#add('skywind3000/asyncrun.vim')
    call dein#add('skywind3000/asynctasks.vim')
    call dein#add('dense-analysis/ale', {
                \ 'lazy': 1,
                \ 'on_ft': ['c', 'cpp', 'rust', 'python', 'asm', 'sh', 'fish', 'bash']
                \ })
    call dein#add('Shougo/echodoc.vim', {
                \ 'lazy': 1,
                \ 'on_ft': ['c', 'cpp', 'python', 'rust']
                \ })      " echo parameter of funciton
    call dein#add('elzr/vim-json', {
                \ 'lazy': 1,
                \ 'on_ft': 'json'
                \ })
    call dein#add('neoclide/coc.nvim', {'on_ft': 'cmake'})   " code completion for CMake
    call dein#add('https://gitee.com/mirrors/youcompleteme.git', {'build': 'python3 install.py --clangd-completer'})                               " code completion for C/C++, Java and Rust.

    " other
    call dein#add('voldikss/vim-translator')          " translator
    call dein#add('voldikss/vim-floaterm')            " popup terminal
    call dein#add('tpope/vim-eunuch', {'on_if': has('unix')})                 " use UNIX command in Vim
    call dein#add('skywind3000/vim-quickui', {
                \ 'lazy': 1,
                \ 'on_if': "has('patch-8.1.2292') == 0 && exists('*nvim_open_win') == 0"
                \ })
    call dein#add('wakatime/vim-wakatime', {
                \ 'lazy': 1,
                \ 'on_event': 'BufRead'
                \ })
    
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
source ~/.config/nvim/tools/gitignore.vim           " create .gitignore automatically
filetype plugin indent on
syntax on
" }}}

" YouCompleteMe setting{{{
"
let g:ycm_auto_trigger = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
" let g:ycm_global_ycm_extra_conf = '/usr/lib/ycmd/ycm_extra_conf.py'
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

" 禁止自动添加头文件
" 详细的补全建议
let g:ycm_clangd_args = [ '--header-insertion=never', '--completion-style=detailed']

let g:ycm_confirm_extra_conf = 0
"}}}

" echodoc setting{{{
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = "floating"
highlight link EchoDocFloat Pmenu"}}}

" ale{{{
"
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
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

function! MyOnBattery()
    return !filereadable('/sys/class/power_supply/AC/online') || readfile('/sys/class/power_supply/AC/online') == ['0']
endfunction

if MyOnBattery()
    let g:ale_completion_delay = 500
    let g:ale_echo_delay = 20
    let g:ale_lint_delay = 500
endif
"}}}

"cpp-enhanced-highlight setting{{{

let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let c_no_curly_error=1"}}}

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
let g:Lf_DefaultExternalTool = s:findder
if s:findder == 'fd'
    let g:Lf_ExternalCommand = 'fd --type f "%s"'           " On MacOSX/Linux
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

let g:gutentags_exclude_filetypes = ['vim', 'sh', 'bash', 'fish', 'txt', 'markdown', 'cmake', 'snippets', 'vimwiki', 'dosini', 'gitcommit', 'make']
" 开启拓展支持
let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.git', '.pro', 'Cargo.toml']

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
let g:gutentags_ctags_extra_args += ['--exclude=_builds/']
let g:gutentags_ctags_extra_args += ['--exclude=doc/']


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


nnoremap <silent> gs :GscopeFind s <C-R><C-W><cr>:cnext<CR>zz
nnoremap <silent> gc :GscopeFind c <C-R><C-W><cr>:cnext<CR>zz
nnoremap <silent> gt :GscopeFind t <C-R><C-W><cr>:cnext<CR>zz
nnoremap <silent> ge :GscopeFind e <C-R><C-W><cr>:cnext<CR>zz
nnoremap <silent> gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
nnoremap <silent> gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
nnoremap <silent> gC :GscopeFind d <C-R><C-W><cr>:cnext<CR>zz
nnoremap <silent> ga :GscopeFind a <C-R><C-W><cr>:cnext<CR>zz
nnoremap <silent> gd :GscopeFind g <C-R><C-W><cr>:cnext<CR>zz
" --------------}}}

" gtags(global) {{{
noremap <C-g> mG:GtagsCursor<CR>zz"}}}

" vista{{{

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
" let g:vista#renderer#icons = {
" \   "function": "\uf794",
" \   "variable": "\uf71b",
" \  }
let g:vista#extensions = ['vimwiki']"}}}

" -----------}}}

" easy-align{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)"}}}

" vim-commentary{{{

autocmd FileType java,c,cpp,rust set commentstring=//\ %s
" autocmd FileType java,c,cpp,rust set commentstring=/*\ %s\ */
autocmd FileType asm set commentstring=#\ %s
"}}}

" indentLine{{{

let g:indentLine_enabled = 1
let g:indentLine_conceallevel = 2
let g:indentLine_char_list = ['|', '¦', '┆', '┊']"}}}

" AutoFormat{{{

" using clang-format as default formatter
" using mozilla style as default C/C++ style
let g:formatdef_my_custom_c = '"clang-format --style=\"{BasedOnStyle: mozilla, IndentWidth: 4}\""'
let g:formatters_c = ['my_custom_c']
let g:formatters_cpp = ['my_custom_c']
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
" noremap <F5> :AsyncTask file-build<cr>
nnoremap  <Leader>fb :AsyncTask file-build<cr>
nnoremap  <Leader>fr :AsyncTask file-run<cr>
nnoremap  <leader>pg :AsyncTask cxx_project-configurate<CR>
nnoremap  <Leader>pb :AsyncTask cxx_project-build<CR>
nnoremap  <Leader>pr :AsyncTask project-run<CR>
nnoremap  <Leader>pd :AsyncTask cxx_project-clean<CR>
nnoremap  <Leader>ft :Asynctask file-test<cr>"}}}

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
    endif
    for dir in unused_plugin_dir
        echomsg dir
        try
            call delete(dir, 'rf')
        catch /.*/
            echoerr "remove unused plugin directory failed"
        endtry
        echomsg "removed unused plugin directory"
    endfor
endfunction

nnoremap <Leader>pi :w<CR><Leader>es:call dein#install()<CR>
nnoremap <leader>pu :call dein#update()<CR>
nnoremap <Leader>pc  :call <SID>PluginClean()<CR>
" }}}

" coc.nvim{{{

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
autocmd FileType cmake,json inoremap <buffer> <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
autocmd FileType cmake,json inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" 希望能够在进入 cmake 文件的 buffer 是开启 coc，退出 buffer是禁止
" coc。问题在于 autocmd 的活动似乎是“或”而不是“与”，无法做到同时同时是 cmake
" 类型且进入缓冲区时设置自动命令。
"
" autocmd FileType cmake,json BufEnter CocEnable
" autocmd FileType cmake,json BufLeave CocDisable
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction



" autocmd FileType vim,c,cpp,rust,bash,java CocDisable}}}

"    vim-which-key{{{
" let g:mapleader = "\<Space>"
" let g:maplocalleader = 'z'
" nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  'z'<CR>}}}

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

" lightline -{{{
let g:lightline = {
            \ 'colorscheme': 'one',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified']],
            \   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
            \ },
            \ 'component_function': {
            \   'linter_warnings': 'LightlineLinterWarnings',
            \   'linter_errors': 'LightlineLinterErrors',
            \   'linter_ok': 'LightlineLinterOK'
            \ },
            \ 'component_type': {
            \   'readonly': 'error',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error',
            \   'linter_ok': 'ok'
            \ },
            \ }
autocmd User ALELint call lightline#update()
" }}}

" vim-mam{{{

nnoremap <Leader>hm :Vman 2 <C-r><C-w><CR>
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

" remap gl<Space> and gL<Space>: remove checkbox
nmap glt <Plug>VimwikiRemoveSingleCB
nmap gLt <Plug>VimwikiRemoveCBInList
" remap <C-Space>:
nmap zv <Plug>VimwikiToggleListItem
" VimwikiToc
nnoremap <Leader>vt :VimwikiTOC<CR>"}}}

" md paste {{{
let g:mdip_imdir_intext = "./images"
"设置默认图片名称。当图片名称没有给出时，使用默认图片名称
nmap <buffer><silent> <Leader>mp :call mdip#MarkdownClipboardImage()<CR>
" --------}}}

" vim-session{{{

let g:session_autosave = 'no'
let g:session_autoload = 'no'
call EnsureDirExists($HOME . '/.vim/session')
let g:session_directory = "~/.vim/session"
"}}}

" vim-tmux-navigator ---------{{{
" let g:tmux_navigator_no_mappings = 1

" nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <M-/> :TmuxNavigatePrevious<cr>
" " ------}}}

" FlyGrep ----{{{
let g:FlyGrep_search_tools = s:grepper
let g:FlyGrep_enable_statusline = 1
nnoremap <Leader>sp :FlyGrep<CR>
" -----}}}

" nerdcommmenter ---{{{

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" }}}

" window shortcut{{{

nnoremap <Leader>wt <C-w>T<CR>  " 将当前窗口移动为 tab

nnoremap <Leader>wo <C-w>o  " 仅保留当前窗口，关闭其他窗口
nnoremap <Leader>wc <C-w>c  " 关闭当前窗口
nnoremap <Leader>wq <C-w>c  " close current window
nnoremap <Leader>wjc <C-w>j<C-w>c<CR>kh " 关闭下面的窗口
nnoremap <Leader>wkc <C-w>k<C-w>c<CR>
nnoremap <Leader>whc <C-w>h<C-w>c<CR>kh
nnoremap <Leader>wlc <C-w>l<C-w>c<CR>kh
nnoremap <Leader>wjq <C-w>j<C-w>c<CR>kh " 关闭下面的窗口
nnoremap <Leader>wkq <C-w>k<C-w>c<CR>
nnoremap <Leader>whq <C-w>h<C-w>c<CR>kh
nnoremap <Leader>wlq <C-w>l<C-w>c<CR>kh

nnoremap <leader>wh :hide<CR>   " 隐藏当前窗口
nnoremap <leader>wjh <C-w>j:hide<CR>3h
nnoremap <leader>wkh <C-w>k:hide<CR>3h
nnoremap <leader>whh <C-w>h:hide<CR>3h
nnoremap <leader>wlh <C-w>l:hide<CR>3h

nnoremap <Leader>wH <C-w>H      " 将当前窗口移动到左边
nnoremap <Leader>wJ <C-w>J
nnoremap <Leader>wL <C-w>L
nnoremap <Leader>wK <C-w>K

nnoremap <Leader>wv <C-w>v      " split current window
nnoremap <Leader>ws <C-w>s      " vertical split current window

nnoremap H <c-w>h
nnoremap L <c-w>l
nnoremap J <c-w>j
nnoremap K <c-w>k

nnoremap <Leader>w- <C-w>-             " decrease current window height
nnoremap <Leader>w+ <C-w>+            " increase current window height
nnoremap <leader>w, <C-w><            " decrease current window widen
nnoremap <Leader>w. <C-w>>             " increase current window widen
tnoremap <M-q> <C-\><C-n>       " 内置终端切换为 normal 模式}}}

" buffer shortcut{{{

nnoremap <leader>bd :bdelete<CR>
nnoremap <Leader><Tab> <C-^>

" }}}

" language specific autocmd  -----------{{{2

" lua{{{
augroup lua
    autocmd!
    autocmd FileType lua setlocal tabstop=2
    autocmd FileType lua setlocal shiftwidth=2
augroup END"}}}

" fish{{{
augroup fish
    autocmd FileType fish compiler fish
    autocmd FileType fish setlocal textwidth=79
    autocmd FileType fish setlocal foldmethod=expr
augroup END"}}}

" vimwiki{{{
augroup vimwiki
    autocmd!
    autocmd FileType vimwiki setlocal wrap
    " autocmd FileType vimwiki, BufWrite VimwikiTOC
augroup END"}}}

" Rust setting{{{

augroup Rust
    autocmd!
    autocmd FileType rust setlocal makeprg=cargo\ $*
    autocmd FileType rust setlocal errorformat=
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
augroup END"}}}

" -----------}}}2

" abbreviation{{{
iabbrev rn return
iabbrev today <C-r>=strftime("%Y-%m-%d")<CR>
" }}}

" tab shortcut{{{
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>- gT
nnoremap <leader>= gt"}}}

" shortcut of open and source vimrc {{{
if has('win32')
    nnoremap <leader>ev :vsplit $HOME/_vimrc<CR>
    nnoremap <leader>es :source $HOME/_vimrc<CR>
elseif has('unix')
    nnoremap <leader>ev :vsplit $HOME/.vimrc<CR>
    nnoremap <leader>es :source $HOME/.vimrc<CR>
endif"}}}

" like unimpaired  -----------{{{2

" Quickfix mapping{{{
noremap ]oq :cclose<CR>
noremap [oq :copen<CR>"}}}

" Vista setting mapping{{{
noremap [ov :Vista<CR>
noremap ]ov :Vista!<CR>
noremap yov :Vista!!<CR>"}}}

" enable/disable paste{{{
noremap [op :setlocal paste<CR>
noremap ]op :setlocal nopaste<CR>
noremap yop :setlocal paste!<CR>"}}}

" -----------}}}2
