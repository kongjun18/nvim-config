" (Neo)vim configuration
" Last Change: 2021-01-12
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-3.0

" guard {{{
if exists('loaded_init_vim') || &cp || version < 700
    finish
endif
let loaded_init_vim = 1
" }}}

" dein ----{{{
if !isdirectory(general#plugin_dir)
    if general#is_unix
		silent !sh ~/.config/nvim/tools/dein.sh ~/.config/nvim/plugged
		autocmd VimEnter * call dein#install()
    else
        :echomsg "Don't support windows"
    endif
endif

" Substitute wget or curl with axel which is a multi-threaded downloader
if executable('axel')
	let g:dein#download_command = 'axel -n 8 -o'
endif

" Don't clone deeply
let g:dein#types#git#clone_depth = 1
let g:dein#install_message_type = 'none'
if general#is_unix
    set runtimepath+=~/.config/nvim/plugged/repos/github.com/Shougo/dein.vim
else
    set runtimepath+=~/vimfiles/plugged/repos/github.com/Shougo/dein.vim
endif
if dein#load_state(general#plugin_dir)
    call dein#begin(general#plugin_dir)
    call dein#add(general#dein_file)
	" Vim enhacement
	call dein#add('kshenoy/vim-signature', {
				\ 'lazy': 1,
				\ 'on_event': 'BufReadPost'
				\})                        " Show marks
	call dein#add('preservim/nerdtree', {
				\ 'lazy': 1,
				\ 'on_cmd': ['NERDTree', 'NERDTreeVCS', 'NERDTreeFromBookmark']
				\ })                                              " File system explorer
	call dein#add('jeffkreeftmeijer/vim-numbertoggle')            " Automatically switch relative line number and absolute line number.
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
    call dein#add('wellle/targets.vim', {
                \ 'lazy': 1,
                \ 'on_event': ['BufReadPost']
                \ })                           " Text objects
    call dein#add('haya14busa/is.vim', {
                \ 'lazy': 1,
                \ 'on_event': ['BufReadPost']
                \ })                            " Some enhancement of incsearch
    call dein#add('tommcdo/vim-exchange', {
                \ 'lazy': 1,
                \ 'on_ev': 'BufReadPost'
                \ })                         " Exchange two words or lines
	call dein#add('SirVer/ultisnips', {
				\ 'on_if':"has('python3')",
                \ 'lazy': 1,
				\ 'on_event': 'TextChangedI'
				\ })                                              " Code snippets engine
	call dein#add('preservim/nerdcommenter', {
                \ 'lazy': 1,
				\ 'on_event': 'BufReadPost'
				\ })
    call dein#add('jiangmiao/auto-pairs', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })                         " Pairs matching/completion
    call dein#add('tpope/vim-repeat', {
                \ 'lazy': 1,
                \ 'on_ev': 'BufReadPost'
                \ })                             " Repeat modification made by vim-commentary, vim-surround
	call dein#add('tpope/vim-unimpaired', {
				\ 'lazy': 1,
				\ 'on_event': 'BufReadPost'
				\ })                                              " Some shortcuts should be built in Vim
    call dein#add('junegunn/vim-easy-align', {
                \ 'lazy': 1,
                \ 'on_ev': 'BufReadPost'
                \ })                      " Align code
	call dein#add('Yggdroot/indentLine', {'on_event': 'BufRead'}) " Indent indication
    call dein#add('Chiel92/vim-autoformat', {
                \ 'lazy': 1,
                \ 'on_ev': 'BufReadPost'
                \ })
	call dein#add('machakann/vim-sandwich') 
	call dein#add('machakann/vim-highlightedyank')                " Highlight yanked area
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
	call dein#add('tpope/vim-fugitive')
    call dein#add('junegunn/gv.vim')
	call dein#add('airblade/vim-gitgutter', {
				\ 'lazy': 1,
				\ 'on_event': 'BufRead'
				\ })                     " Show diff status

	" Status
	call dein#add('itchyny/lightline.vim')                      " Status line
	call dein#add('lambdalisue/battery.vim')
	call dein#add('luochen1990/rainbow')                        " Give unmatched pairs different color
	call dein#add('itchyny/vim-cursorword')                     " Underline the word of cursor
	call dein#add('lfv89/vim-interestingwords')                 " Highlight interesting word

	" Language-enhancement
    call dein#add('dag/vim-fish', {
                \ 'lazy': 1,
                \ 'on_ft': 'fish',
                \ })                                           " A syntax file of fish shell
    if general#nvim_is_latest
        call dein#add('nvim-treesitter/nvim-treesitter', {
                \ 'lazy': 1,
                \ 'on_ft': ['c', 'cpp', 'lua', 'json', 'python', 'rust', 'bash', 'toml'],
                \ })
    else
        call dein#add('jackguo380/vim-lsp-cxx-highlight', {
                    \ 'lazy': 1,
                    \ 'on_ft': ['c', 'cpp'],
                    \ })
        call dein#add('wsdjeg/vim-lua', {
                    \ 'lazy': 1,
                    \ 'on_ft': 'lua',
                    \ })                                        " A syntax file of Lua
        call dein#add('elzr/vim-json', {
                    \ 'lazy': 1,
                    \ 'on_ft': 'json',
                    \ })                                        " A syntax file of json
        call dein#add('cespare/vim-toml', {
                    \ 'lazy': 1,
                    \ 'on_ft': 'toml',
                    \ })
        call dein#add('Townk/vim-qt', {
                    \ 'lazy': 1,
                    \ 'on_ft': 'cpp',
                    \ })                                           " A syntax file of Qt
    endif
	" VimL
	call dein#add('tpope/vim-scriptease', {
				\ 'lazy': 1,
				\ 'on_ft': 'vim'
				\ })                                           " Ease the development of vimscript

	" Color scheme
	call dein#add('sainnhe/edge')							   " Defualt color scheme
    call dein#add('cormacrelf/vim-colors-github')

	" project management
	call dein#add('Yggdroot/LeaderF', {'build': ':LeaderfInstallCExtension'})                          " Fuzzy finder
    call dein#add('neoclide/coc.nvim', {
                \ 'merge': 0,
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('fannheyward/coc-rust-analyzer', {
                \ 'lazy': 1,
                \ 'build': 'yarn install --frozen-lockfile',
                \ 'depends': 'coc.nvim',
                \ 'on_ft': 'rust'
                \ })
    call dein#add('iamcco/coc-vimlsp', {
                \ 'lazy': 1,
                \ 'build': 'yarn install --frozen-lockfile',
                \ 'depends': 'coc.nvim',
                \ 'on_ft': 'vim'
                \ })
	call dein#add('kkoomen/vim-doge', {
				\ 'hook_source_post': ':call doge#install()<CR>'
				\ })                                         " Document code
	call dein#add('tpope/vim-projectionist')                     " Switch between files
	call dein#add('skywind3000/asyncrun.vim')                    " Run shell command asynchronously
	call dein#add('skywind3000/asynctasks.vim')                  " Run tasks asynchronously
	call dein#add('Shougo/echodoc.vim', {
				\ 'lazy': 1,
				\ 'on_ft': ['c', 'cpp', 'python', 'rust', 'vim']
				\ })                                            " Echo parameters of function

	" other
	call dein#add('yianwillis/vimcdoc')                         " Chinese version of vi mdoc
	call dein#add('voldikss/vim-translator')                    " Translator
	call dein#add('voldikss/vim-floaterm')                      " Popup terminal
	call dein#add('tpope/vim-eunuch', {'on_if': general#is_unix})   " use UNIX command in Vim
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
if strftime("%H") <= 15
    let g:github_colors_soft = 1
    set background=light
    colorscheme github
else
    let g:edge_style = 'neon'
    let g:edge_better_performance = 1
    set background=dark
    colorscheme edge
endif
" }}}

" echodoc setting{{{
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = "floating"
highlight link EchoDocFloat Pmenu"}}}

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
let g:Lf_DefaultExternalTool = general#findder
if general#findder == 'fd'
	let g:Lf_ExternalCommand = 'fd -E _builds -E doc -E target --type f "%s"'   
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
let g:Lf_WildIgnore = {
			\ 'dir': ['_builds', 'target', 'doc', '.cache', '.ccls-cache'],
			\ 'file': ['Makefile', '*.txt', '*.md', '*.wiki', '*.ini', '*.json', '*.js', '*.html', '*.css']
			\}
" integrate LeaderF, guentags and gtags
let g:Lf_CacheDirectory = expand('~')
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsGutentags = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_RootMarkers = ['.root', '.git', '.pro', 'Cargo.toml']   " 设置项目根目录标记
let g:Lf_WorkingDirectoryMode = 'A'                " 设置 LeaderF 工作目录为项目根目录，如果不在项目中，则为当前目录。
let g:Lf_ShortcutF = "<Leader>f"
let g:Lf_ShortcutB = "<Leader>bl"
nnoremap <Leader>p :LeaderfFunctionAll<CR>
nnoremap <Leader>l :LeaderfBufTagAll<CR>
nnoremap <Leader>d :LeaderfTag<CR>
nnoremap <leader>h :LeaderfHelp<CR>
nnoremap <Leader>rg :Leaderf rg<Space><Right>
nnoremap <leader>T :Leaderf task<CR>
"}}}

" tag system ------------{{{
nnoremap <silent> ge :GscopeFind e <C-R><C-W><cr>:cnext<CR>zz
nnoremap <silent> gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
nnoremap <silent> gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>:cnext<CR>
nnoremap <silent> ga :GscopeFind a <C-R><C-W><cr>:cnext<CR>zz

" gutentags ----------------{{{
" Exclude these types
let g:gutentags_exclude_filetypes = ['text', 'markdown', 'cmake', 'snippets', 'vimwiki', 'dosini', 'gitcommit', 'git', 'json', 'help', 'html', 'javascript', 'css']

" Use pygment to extend gtags
let $GTAGSLABEL = 'native-pygments'

" Set root makers of project
let g:gutentags_project_root = general#project_root_maker

" All ctags files suffixed with .tag'
let g:gutentags_ctags_tagfile = '.tag'

" Use ctags and gtags
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	set csprg=gtags-cscope
	let g:gutentags_modules += ['gtags_cscope']
endif

" Please use universal-ctags instead of exuberant-ctags which is not maintained. Vista doesn't
" support old exuberant-ctags.
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--exclude=_builds']
let g:gutentags_ctags_extra_args += ['--exclude=.cache']
let g:gutentags_ctags_extra_args += ['--exclude=doc']
let g:gutentags_ctags_extra_args += ['--exclude=plugged']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" Integrate Leaderf and gutentags
" Put all gtags file in ~/.LfCache/gtags
let g:gutentags_cache_dir = expand(g:Lf_CacheDirectory . '/.LfCache/gtags')

" Don't load gtags_cscope database automatically
let g:gutentags_auto_add_gtags_cscope = 0
" }}}

"       gutentags_plus ------------{{{

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 0
let g:gutentags_plus_nomap = 1


if general#only_use_static_tag
	nnoremap <silent> gs :GscopeFind s <C-R><C-W><cr>:cnext<CR>zz
	nnoremap <silent> gd :GscopeFind g <C-R><C-W><cr>:cnext<CR>zz
    nnoremap <silent> gc :GscopeFind c <C-R><C-W><cr>:cnext<CR>zz
    nnoremap <silent> gt :GscopeFind t <C-R><C-W><cr>:cnext<CR>zz
    nnoremap <silent> gC :GscopeFind d <C-R><C-W><cr>:cnext<CR>zz
endif

" --------------}}}

" gtags(global) {{{
noremap <C-g> mG:GtagsCursor<CR>zz"}}}

" vista{{{

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
  \ 'cpp': 'coc'
  \ }
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
" let g:formatdef_my_custom_c = '"clang-format --style=\"{BasedOnStyle: mozilla, IndentWidth: 4}\""'
" let g:formatters_c = ['my_custom_c']
" let g:formatters_cpp = ['my_custom_c']

" use lua-format as default lua formatter
let g:formatdef_my_custom_lua = 'lua-format -i'
let g:formatter_lua = ['my_custom_lua']
nnoremap <Leader>bf :Autoformat<CR>
"}}}

" autopairs{{{

let g:AutoPairsShortcutToggle = ''          " disable shortcut
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
endif
"}}}

" Asyncrun and Asynctask{{{
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

" Edit system-wide tasks.ini
command! TaskEdit exec 'vsp ' . g:vimfiles . '/tasks.ini'

" Run program in tab
let g:asynctasks_term_pos = 'tab'
" Set quickfix window height
let g:asyncrun_open = 10
" Bell when task finished
let g:asyncrun_bell = 1
" Set root makers of project
let g:asyncrun_rootmarks = general#project_root_maker

nnoremap  <Tab>5 :AsyncTask file-build<cr>
nnoremap  <Tab>6 :AsyncTask file-run<cr>
nnoremap  <Tab>7 :AsyncTask project-configure<CR>
nnoremap  <Tab>8 :AsyncTask project-build<CR>
nnoremap  <Tab>9 :AsyncTask project-run<CR>
nnoremap  <Tab>0 :AsyncTask project-clean<CR>
"}}}

" vim-translator{{{

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
nmap <silent> <Leader>tx <Plug>TranslateX
"}}}

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
if !general#only_use_static_tag
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gs <Plug>(coc-references)
    nmap <silent> gt <Plug>(coc-type-definition)
    nmap <silent> gc :call CocLocations('ccls','$ccls/call')<CR>
    nmap <silent> gC :call CocLocations('ccls','$ccls/call', {'callee': v:true})<CR>
endif


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
nmap <Leader>rf <Plug>(coc-refactor)

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
" }}}

" leetcode{{{

let g:leetcode_solution_filetype = ['c', 'cpp', 'rust']
let g:leetcode_browser = 'firefox'
let g:leetcode_china = 1
"}}}

"  lightline -{{{
let g:lightline = {
            \ 'colorscheme': 'edge',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified'], ['gitbranch', 'gutentags']],
            \   'right': [['lineinfo'], ['percent'], ['readonly'], ['cocstatus'], ['battery']]
            \ },
            \ 'component_function': {
            \   'gutentags': 'gutentags#statusline',
            \   'gitbranch': 'FugitiveHead',
            \   'cocstatus': 'coc#status',
            \   'battery': 'battery#component'
            \ },
            \ 'component_type': {
            \   'readonly': 'error',
            \ },
            \ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
autocmd User GutentagsUpdated,GutentagsUpdating call lightline#update()
" }}}

" vim-battery {{{
let g:battery#update_statusline = 1
let g:battery#symbol_charging = '⚡'
"}}}

" vim-mam{{{
nnoremap gm :Vman 3 <C-r><C-w><CR>
nnoremap gk :vertical help <C-r><C-w><CR>
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

" vim-session{{{

let g:session_autosave = 'no'
let g:session_autoload = 'no'
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

" Usefull when comment argument 
let g:NERDAllowAnyVisualDelims = 0
" }}}

" nerdtree {{{
let NERDTreeRespectWildIgnore = 1
augroup nerdtree
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
"}}}

" vim-fugitive {{{
" Integrate vim-fugitive and asyncrun.vim, which makes Gpull and Gfetch
" asynchronously
"
" This command will cause vim-dispatch and all other make wrapper plugins go
" wrong 
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
"}}}

" gitgutter {{{
" Disable mappings
let g:gitgutter_map_keys = 0
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)
"}}}

" doge {{{
let g:doge_enable_mappings = 0
let doge_doc_standard_c = 'doxygen_javadoc_banner'
let doge_doc_standard_cpp = 'doxygen_javadoc_banner'
let g:doge_mapping_comment_jump_forward = '<C-j>'
let doge_mapping_comment_jump_backward = '<C-k'
"}}}

" vim-sandwich {{{
runtime macros/sandwich/keymap/surround.vim
" }}}

" abbreviation{{{
iabbrev rn return
iabbrev today <C-r>=strftime("%Y-%m-%d")<CR>
" }}}

" nvim-treesitter {{{
if general#nvim_is_latest
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'c', 'cpp', 'toml', 'json', 'lua', 'python', 'bash', 'rust'},
  highlight = {
    enable = true, 
  },
  indent = {
      enable = true,
  }
}
EOF
endif
"}}}
