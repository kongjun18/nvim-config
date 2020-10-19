" (Neo)vim configuration 
" Last Change: 2020-10-19
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0

" general setting ---- {{{
function! EnsureDirExists(dir)
    if !isdirectory(a:dir)
        echomsg a:dir
        call mkdir(a:dir, 'p')
    endif
endfunction

set nocompatible

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
filetype on
filetype plugin on
filetype indent on

if &shell =~? 'fish'
    set shellpipe=&>\ %s          " fish shell
else
    set shellpipe=>\ %s\ 2>&1   " 用来压缩调用外部命令（比如make、grep）时的输出
endif

if has('win32')
    autocmd VimEnter * cd C:\Users\kongjun\Documents
endif

let s:grepper = 'grep'
let s:findder = 'find'
if executable('fd')
    let s:findder = 'fd'
endif
if executable('rg')
    let s:grepper = 'rg'
    set grepprg=rg\ --ignore-case\ --vimgrep\ $*   " grep 使用 rg
endif

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

" plugins which I installed  -----------{{{

if has('unix')
    if empty(glob('~/.vim/autoload/plug.vim'))
          silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
            if isdirectory('~/.vim')
                rename('~/.vim', '~/.vim.backup.madeby.kongjun')
            endif
            if filereadable('~/.vimrc')
                rename('~/.vimrc', '~/.vim.backup.madeby.kongjun')
            endif
            system('ln -s ~/.config/nvim ~/.vim')
            system('ln -s ~/.config/nvim/init.vim ~/.vimrc')
    endif
endif

let loaded_matchit = 1

" Plugins installed by vim-plug
if has('win32')
    call plug#begin("C:\\Users\\kongjun\\vimfiles\\plugged")
else
    call plug#begin("~/.vim/plugged")
endif

" Vim enhacement
Plug 'jeffkreeftmeijer/vim-numbertoggle'            " automatically switch relative line number and absulute line number.
Plug 'rhysd/accelerated-jk'                         " accelerate speed of key 'j' and 'k'
Plug 'bronson/vim-visual-star-search'               " use * and # in visual mod
Plug 'tweekmonster/startuptime.vim'                 " measure startup time
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'easymotion/vim-easymotion'
Plug 'wsdjeg/FlyGrep.vim'
Plug 'drmikehenry/vim-fixkey'                       " use ALT in Vim
Plug 'lilydjwg/fcitx.vim'
Plug 'ryanoasis/vim-devicons'                       " show icons of some file types
Plug 'wincent/terminus'                             " add some GUI feature for terminal Vim
Plug 'vim-utils/vim-man'                            " read man page in Vim
Plug 'mbbill/undotree'                              " display undo operations in tree view
Plug 'farmergreg/vim-lastplace'                     " keep cursor to the same positon where we exit session
Plug 'xolox/vim-misc'                               " dependency of vim-session
Plug 'xolox/vim-session'                            " save Vim session without pain

" text edit
Plug 'wellle/targets.vim'                           " text objects
Plug 'haya14busa/is.vim'                            " some enhancement of incsearch
Plug 'matze/vim-move'                               " move text block in visual mode
Plug 'tommcdo/vim-exchange'                         " exchange two words or lines
Plug 'SirVer/ultisnips'                             " code snippets engine
Plug 'honza/vim-snippets'                           " code snippets for popular languages
Plug 'tpope/vim-commentary'                         " comment/uncomment code
Plug 'jiangmiao/auto-pairs'                         " pairs matching/completion
Plug 'tpope/vim-repeat'                             " repeat modification made by vim-commentary, vim-surround
Plug 'tpope/vim-unimpaired'                         " some shortcut should be built in Vim
Plug 'junegunn/vim-easy-align'                      " align code
Plug 'Yggdroot/indentLine', {'on': ['BufEnter']}    " indent indication
Plug 'Chiel92/vim-autoformat'                       " wrapper of code formater
Plug 'https://gitee.com/kongjun18/vim-sandwich.git' " a fork of machakann/vim-sandwich, using vim-surround mapping
Plug 'machakann/vim-highlightedyank'                " highlight yanked area

" leetcode
Plug 'ianding1/leetcode.vim'                        " practise leetcode in Vim

" vimwiki
Plug 'vimwiki/vimwiki'                              " personal wiki
Plug 'mattn/calendar-vim'                           " calendar

" tag system
Plug 'vim-scripts/gtags.vim'
Plug 'liuchengxu/vista.vim'
Plug 'ludovicchabant/vim-gutentags', {'for': ['c', 'cpp', 'rust', 'python']}
Plug 'skywind3000/gutentags_plus', {'for': ['c', 'cpp', 'rust', 'python']}  "默认的scope操作不会直接跳转到quickfix中，需要修改源代码

" debug
Plug 'puremourning/vimspector', {'for': ['c', 'cpp', 'rust', 'python']}

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

" status
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'luochen1990/rainbow'
Plug 'itchyny/vim-cursorword'   " underline the word of cursor
Plug 'lfv89/vim-interestingwords' " highlight word

" language-enhancement
Plug 'Townk/vim-qt', {'for': ['cpp']}
Plug 'wsdjeg/vim-lua', {'for': ['lua']}     " Lua 语法高亮
Plug 'dag/vim-fish', {'for': ['fish']}
Plug 'cespare/vim-toml', {'for': ['toml']}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']} "cpp hightlight

" markdown
Plug 'tpope/vim-markdown' , {'for': ['makrdown']}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for':['markdown']  }
Plug 'mzlogin/vim-markdown-toc',     {'for':['markdown']}
Plug 'ferrine/md-img-paste.vim', {'for': ['markdown']}

" vimL
Plug 'tpope/vim-scriptease', {'for': ['vim']}             " make vimL easy

" color scheme
Plug 'KeitaNakamura/neodark.vim'
Plug 'rakr/vim-one'


" project management
Plug 'Yggdroot/LeaderF'                 " fuzzy find
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp', 'python']}   " manage Doxygen
Plug 'tpope/vim-projectionist'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'dense-analysis/ale'               " linter
Plug 'Shougo/echodoc.vim', {'for': ['java', 'rust', 'ruby', 'lua', 'bash', 'vim', 'c', 'cpp']}      " echo parameter of funciton
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['cmake', 'json']}   " code completion for CMake and Json
Plug 'Valloric/YouCompleteMe'                                " code completion for C/C++, Java and Rust.
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}          " automatically generator YCM configuration.


" other
Plug 'voldikss/vim-translator'          " translator
Plug 'voldikss/vim-floaterm'            " popup terminal
Plug 'tpope/vim-eunuch'                 " use UNIX command in Vim
Plug 'skywind3000/vim-quickui'
Plug 'wakatime/vim-wakatime'

call plug#end()
" --------------------}}}

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
let g:ycm_clangd_args = [ '--header-insertion=never', '--completion-style=detailed', '--compile-commands-dir=_builds' ]

let g:ycm_confirm_extra_conf = 0
"}}}

" echodoc setting{{{
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = "floating"
highlight link EchoDocFloat Pmenu"}}}

" ale{{{
let g:ale_linters_explicit = 1
" \ 'c': ['gcc', 'cppcheck'],
" \ 'cpp': ['gcc', 'cppcheck'],
let g:ale_linters = {
            \ 'asm': ['gcc'],
            \ 'rust': ['cargo', 'rls'],
            \ 'sh': ['shellcheck', 'sh'],
            \ 'fish': ['fish']
            \}
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1

" 使用 quickfix 会与 gtags-scope 重叠，所以使用 location list
let g:ale_set_quickfix = 0
" let g:ale_set_loclist = 1
" let g:ale_open_list = 1
" let g:ale_keep_list_window_open = 1

" let g:ale_c_cc_executable='gcc'
" let g:ale_cpp_cc_executable='g++'
"  -Wall will open option -Wconversion.
"  -Wextra will open option -Wsign-compare
"  -Wconversion open -Wsign-conversion defaultly.
" let g:ale_c_cc_options = '-Wall -Wextra -Wfloat-equal -Winline -Wduplicated-branches -Wduplicated-cond -Wunused -std=gnu11'
" "  -Wconversion don't open -Wsign-conversion for C++
" "  I use ISO C++, so open -pedantic-errors to find behaviors which break the standard.
" let g:ale_cpp_cc_options = '-pedantic-errors -Wall -Wextra -Wsign-conversion -Wfloat-equal -Winline -Wduplicated-branches -Wduplicated-cond -Wunused -std=c++20'
" let g:ale_c_cppcheck_options = '--enable=all --suppress=missingIncludeSystem --std=c11'
" let g:ale_cpp_cppcheck_options = '--enable=all --suppress=missingIncludeSystem --std=c++20'

" 使用 compile_commands.json，在当前目录的 _builds 中查找。
let g:ale_c_build_dir_names = ['_builds']

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
    return readfile('/sys/class/power_supply/AC/online') == ['0']
    return 0
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

" tag system ------------{{{

"       gutentags ----------------{{{

" 调试使用
let g:gutentags_define_advanced_commands = 1
let g:gutentags_trace = 1

" 开启拓展支持
let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
" let $GTAGSCONF =

" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.project', '.git', 'Cargo.toml', '.pro', ]

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

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

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 将自动生成的gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
if has('win32')
    let g:gutentags_cache_dir = expand("C:Users\\kongjun\\Documents\\.cache\\tags")
    let g:gutentags_gtags_dbpath ="C:Users\\kongjunDocuments\\.cache\\tags"
elseif has('unix')
    let g:gutentags_cache_dir = expand('~/.cache/tags')
    let g:gutentags_gtags_dbpath = '~/.cache/tags'
endif

" 自动加载gtags_cscope数据库
let g:gutentags_auto_add_gtags_cscope = 1
" }}}

"       gutentags_plus ------------{{{

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 0
let g:gutentags_plus_nomap = 1

noremap <silent> <leader>cs :GscopeFind s <C-R><C-W><cr>:cnext<CR>zz
noremap <silent> <leader>cg :GscopeFind g <C-R><C-W><cr>:cnext<CR>zz
noremap <silent> <leader>cc :GscopeFind c <C-R><C-W><cr>:cnext<CR>zz
noremap <silent> <leader>ct :GscopeFind t <C-R><C-W><cr>:cnext<CR>zz
noremap <silent> <leader>ce :GscopeFind e <C-R><C-W><cr>:cnext<CR>zz
noremap <silent> <leader>cf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
noremap <silent> <leader>ci :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
noremap <silent> <leader>cd :GscopeFind d <C-R><C-W><cr>:cnext<CR>zz
noremap <silent> <leader>ca :GscopeFind a <C-R><C-W><cr>:cnext<CR>zz
noremap <silent> <leader>cz :GscopeFind z <C-R><C-W><cr>:cnext<CR>zz
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
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)"}}}

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
    finish
endif

call quickui#menu#reset()

call quickui#menu#install('&Build', [
            \ [ "Build &File", 'AsyncTask file-build' ],
            \ [ "Run &File", 'AsyncTask file-run' ],
            \ [ "Build &Project", 'AsyncTask project-build' ],
            \ [ "Run &Project", 'AsyncTask project-run' ],
            \ [ "Run &Test", 'AsyncTask file-test' ]
            \ ])
call quickui#menu#install('&Symbol', [
            \ [ "Find &Definition\t(GNU Global)", 'call MenuHelp_Gscope("g")', 'GNU Global search g'],
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

call quickui#menu#install('&Vimwiki', [
            \ ["&Vimwiki2HTMLBrowse", "Vimwiki2HTMLBrowse", "Convert Vimwiki to HTML and browse it"],
            \ ['&VimwikiTOC', "VimwikiTOC", "Generate TOC"]
            \ ])

call quickui#menu#install('&Plugin', [
            \ ["Plugin &Snapshot", "PlugSnapshot", "Update snapshort"],
            \ ["Plugin &Update", "PlugUpdate", "Update plugin"],
            \ ["Plugin &upgrade", "PlugUpgrade", "Upgrade plugin manager"],
            \ ["Plugin &Install", "PlugInstall", "Install plugin"],
            \ ["Plugin &Clean", "PlugClean", "Clean plugin"]
            \ ])


call quickui#menu#install('Help (&?)', [
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
nnoremap <localleader>k :call quickui#preview#scroll(-5)<cr>"}}}

"       Asyncrun and Asynctask{{{

" 自动打开 quickfix window ，高度为 10
let g:asyncrun_open = 10

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置项目根
let g:asyncrun_rootmarks = ['.git', '.root', 'project', 'Cargo.toml']

" 在下方的内置终端中运行任务
let g:asynctasks_term_pos = 'tab'
"
" 外部终端运行任务
" let g:asynctasks_term_pos = 'external'
let g:asynctasks_term_rows = 20    " 设置纵向切割时，高度为 10
let g:asynctasks_term_cols = 80    " 设置横向切割时，宽度为 80

" set profile clang
let g:asynctasks_profile = 'gcc'

" " 编译、运行
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

" vim-plug and plugin shortcut{{{

nmap <Leader>pin :w<CR><Leader>es:PlugInstall<CR>
nnoremap <leader>pup :PlugUpdate<CR>
nnoremap <Leader>pug :PlugUpgrade<CR>
nnoremap <Leader>pc  :PlugClean<CR>
nnoremap <Leader>pst :PlugStatus<CR>
nnoremap <Leader>pss :PlugSnapshot<CR>"}}}

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

" LeaderF{{{

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_DefaultExternalTool = s:findder
if s:findder == 'fd'
    let g:Lf_ExternalCommand = 'fd --type f "%s"'           " On MacOSX/Linux
endif
let g:Lf_RootMarkers = ['.project', '.root', '.git', 'Cargo.toml', '.pro']   " 设置项目根目录标记
let g:Lf_WorkingDirectoryMode = 'A'                " 设置 LeaderF 工作目录为项目根目录，如果不在项目中，则为当前目录。

let g:Lf_ShortcutF = "<Leader>lf"
let g:Lf_ShortcutB = "<Leader>lb"
nnoremap <Leader>lp :LeaderfFunction<CR>
nnoremap <Leader>lt :LeaderfBufTag<CR>
nnoremap <Leader>ld :LeaderfTag<CR>
nnoremap <leader>lh :LeaderfHelp<CR>
"}}}

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
