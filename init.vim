" (Neo)vim configuration
" Last Change: 2021-05-12
" Author: Kong Jun <kongjun18@outlook.com>
" Github: https://github.com/kongjun18
" License: GPL-2.0


" guard {{{
if exists('loaded_init_vim') || &cp || version < 700
    finish
endif
let loaded_init_vim = 1

" }}}

" dein ----{{{
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
    call dein#add('camspiers/animate.vim', {
                \ 'lazy':1,
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('camspiers/lens.vim', {
                \ 'lazy':1,
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('kongjun18/vim-rest-reminder', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })
	call dein#add('kshenoy/vim-signature', {
				\ 'lazy': 1,
				\ 'on_event': 'BufReadPost'
				\})                        " Show marks
	call dein#add('preservim/nerdtree', {
                \ 'rev': '6.10.9',
				\ 'lazy': 1,
				\ 'on_cmd': ['NERDTree', 'NERDTreeVCS', 'NERDTreeFromBookmark', 'NERDTreeToggle', 'NERDTreeToggleVCS']
				\ })                                              " File system explorer
    call dein#add('jeffkreeftmeijer/vim-numbertoggle', {
                \ 'lazy': 1,
                \ 'on_event': 'BufWinEnter'
                \ })            " Automatically switch relative line number and absolute line number.

    call dein#add('kdav5758/TrueZen.nvim', {
                \ 'lazy': 1,
                \ 'on_if': general#nvim_is_latest,
                \ 'on_event': 'BufWinEnter',
                \ 'hook_post_source': 'call ConfigureTrueZen()'
                \ })
    call dein#add('nacro90/numb.nvim', {
                \ 'lazy': 1,
                \ 'on_if': general#nvim_is_latest,
                \ 'on_event': 'BufWinEnter',
                \ 'hook_post_source': 'call ConfigureNumb()'
                \ })
    call dein#add('andymass/vim-matchup', {
                \ 'rev': 'v0.6.0',
                \ 'lazy':1,
                \ 'on_event': 'BufReadPost'
                \ })
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
    call dein#add('skywind3000/vim-auto-popmenu', {
                \ 'lazy': 1,
                \ 'on_ft': ['text', 'markdown', 'gitcommit', 'vimwiki']
                \ })
    call dein#add('skywind3000/vim-dict', {
                \ 'lazy': 1,
                \ 'on_ft': ['text', 'markdown', 'gitcommit', 'vimwiki']
                \ })

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
                \ 'rev': '3.2',
                \ 'lazy': 1,
				\ 'on_if':"has('python3')",
                \ 'on_event': 'TextChangedI'
				\ })                                              " Code snippets engine
    call dein#add('preservim/nerdcommenter', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost',
                \ 'hook_post_source': 'call CreateCommenterMappings()'
                \ })
    call dein#add('jiangmiao/auto-pairs', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })                         " Pairs matching/completion
    call dein#add('tpope/vim-repeat', {
                \ 'lazy': 1,
                \ 'on_ev': 'BufReadPost'
                \ })                             " Repeat modification made by vim-commentary, vim-surround
    call dein#add('kongjun18/vim-unimpaired', {
                \ 'lazy': 1,
                \ 'on_map': ['[a',']a','[A',']A','[b',']b','[B',']B','[l',']l','[L',']L','[<C-L>',']<C-L>','[q',']q','[Q',']Q','[<C-Q>',']<C-Q>','[t',']t','[T',']T','[<C-T>',']<C-T>','[ob',']ob','yob','[oc',']oc','yoc','[od',']od','yod','[oh',']oh','yoh','[oi',']oi','yoi','[ol',']ol','yol','[on',']on','yon','[or',']or','yor','[os',']os','yos','[ou',']ou','you','[ow',']ow','yow','[ox',']ox','yox','<Space>',']<Space>','[e',']e']
                \ })
    call dein#add('junegunn/vim-easy-align', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })                      " Align code
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
    call dein#add('preservim/tagbar', {
                \ 'lazy': 1,
                \ 'on_event': 'BufWinEnter'
                \ })
	call dein#add('ludovicchabant/vim-gutentags')               " Generate tags automatically
	call dein#add('skywind3000/gutentags_plus')                 " Switch cscope automatically

	" debug
	call dein#add('puremourning/vimspector', {
				\ 'lazy': 1,
                \ 'on_cmd': 'BufReadPost'
				\ })                                            " Debug adaptor of Vim

	" Git
	call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-rhubarb', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('junegunn/gv.vim')
	call dein#add('airblade/vim-gitgutter', {
				\ 'lazy': 1,
				\ 'on_event': 'BufRead'
				\ })                     " Show diff status

	" Status
    call dein#add('itchyny/lightline.vim')                      " Status line
	call dein#add('luochen1990/rainbow')                        " Give unmatched pairs different color
	call dein#add('itchyny/vim-cursorword')                     " Underline the word of cursor
	call dein#add('lfv89/vim-interestingwords')                 " Highlight interesting word

	" Language-enhancement
    call dein#add('dag/vim-fish', {
                \ 'lazy': 1,
                \ 'on_ft': 'fish',
                \ })                                           " A syntax file of fish shell
    if general#nvim_is_latest
        call dein#add('nvim-treesitter/nvim-treesitter', {'merge': 0})
        call dein#add('nvim-treesitter/nvim-treesitter-textobjects', {
                    \ 'lazy': 1,
                    \ 'on_event': 'BufReadPost'
                    \ })
    else
        call dein#add('jackguo380/vim-lsp-cxx-highlight', {
                    \ 'lazy': 1,
                    \ 'on_ft': ['c', 'cpp'],
                    \ 'depends': 'coc.nvim'
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
    call dein#add('editorconfig/editorconfig-vim')
	call dein#add('Yggdroot/LeaderF', {
                \ 'build': ':LeaderfInstallCExtension'}
                \ )                          " Fuzzy finder
    call dein#add('neoclide/coc.nvim', {
                \ 'lazy': 1,
                \ 'merge': 0,
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('dense-analysis/ale', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('maximbaz/lightline-ale', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost'
                \ })
    call dein#add('kkoomen/vim-doge', {
                \ 'rev': 'v3.9.1',
                \ 'lazy': 1,
                \ 'on_ft': ['c', 'cpp'],
                \ 'hook_post_update': 'call dein#source("vim-doge") | call doge#install()'
                \ })                                         " Document code
	call dein#add('tpope/vim-projectionist')                     " Switch between files
	call dein#add('skywind3000/asyncrun.vim', {'rev': 'v2.8.6'})                    " Run shell command asynchronously
	call dein#add('skywind3000/asynctasks.vim')                  " Run tasks asynchronously
	call dein#add('Shougo/echodoc.vim', {
				\ 'lazy': 1,
				\ 'on_ft': ['c', 'cpp', 'python', 'rust', 'vim']
				\ })                                            " Echo parameters of function

	" other
	call dein#add('yianwillis/vimcdoc')                         " Chinese version of vi mdoc
	call dein#add('voldikss/vim-translator')                    " Translator
    call dein#add('voldikss/vim-floaterm', {
                \ 'lazy': 1,
                \ 'on_map': ['[ot',']ot']
                \ })                      " Popup terminal
    call dein#add('skywind3000/vim-terminal-help', {
                \ 'lazy': 1,
                \ 'on_event': 'BufReadPost',
                \ 'on_map': '<M-=>'
                \ })
	call dein#add('skywind3000/vim-quickui', {
                \ 'rev': 'v1.3.2',
				\ 'lazy': 1,
				\ 'on_if': "has('patch-8.1.2292') == 0 && exists('*nvim_open_win') == 0"
				\ })                                            " Simple menu bar of terminal Vim
    call dein#add('liuchengxu/graphviz.vim', {
                \' lazy': 1,
                \ 'on_ft': 'dot'
                \ })
	call dein#end()
	call dein#save_state()
endif

if dein#check_install()                                         " Install plugins automatically
	call dein#install()
endif
filetype plugin indent on                                       " Use filetype-specific plugins
syntax on

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

let g:Lf_PreviewInPopup = 1
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

" Only used when g:Lf_UseVersionControlTool is 0 or files are not inside a
" repo
let g:Lf_WildIgnore = {
			\ 'dir': ['_builds', 'target', 'doc', '.cache', '.ccls-cache'],
			\ 'file': split(&wildignore, ',')
			\}
let g:Lf_RootMarkers = general#project_root_makers
let g:Lf_WorkingDirectoryMode = 'A'                " 设置 LeaderF 工作目录为项目根目录，如果不在项目中，则为当前目录。
let g:Lf_ShortcutF = "<Leader>f"
let g:Lf_ShortcutB = "<Leader>bl"
nnoremap <silent><Leader>p :LeaderfFunctionAll<CR>
nnoremap <silent><Leader>l :LeaderfBufTagAll<CR>
nnoremap <silent><Leader>d :LeaderfTag<CR>
nnoremap <silent><leader>h :LeaderfHelp<CR>
nnoremap <silent> <Leader>rg :Leaderf rg <Space><Right>
nnoremap <silent><leader>T :Leaderf task<CR>
"}}}

" coc.nvim{{{
let g:coc_global_extensions = ['coc-vimlsp', 'coc-rust-analyzer']
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

" GoTo code navigation.
nmap gD <Plug>(coc-declaration)
if !general#only_use_static_tag
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gs <Plug>(coc-references)
    nmap <silent> gt <Plug>(coc-type-definition)
endif


" Use gK to show documentation in preview window.
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

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" }}}

" static tag system ------------{{{
" gutentags {{{
" Exclude these types
let g:gutentags_exclude_filetypes = ['text', 'markdown', 'cmake', 'snippets', 'vimwiki', 'dosini', 'gitcommit', 'git', 'json', 'help', 'html', 'javascript', 'css', 'vim', 'txt', 'man']

" Use pygment to extend gtags
let $GTAGSLABEL = 'native-pygments'

" Set root makers of project
let g:gutentags_project_root = general#project_root_makers

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

" Please use universal-ctags instead of exuberant-ctags which is not maintained. Tagbar doesn't
" support old exuberant-ctags.
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--exclude=_builds']
let g:gutentags_ctags_extra_args += ['--exclude=Debug']
let g:gutentags_ctags_extra_args += ['--exclude=Release']
let g:gutentags_ctags_extra_args += ['--exclude=Build']
let g:gutentags_ctags_extra_args += ['--exclude=.cache']
let g:gutentags_ctags_extra_args += ['--exclude=doc']
let g:gutentags_ctags_extra_args += ['--exclude=plugged']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" Integrate Leaderf and gutentags
let g:gutentags_cache_dir = general#vimfiles .. general#delimiter .. '.tags'

" Don't load gtags_cscope database automatically
let g:gutentags_auto_add_gtags_cscope = 0
" }}}

nnoremap <silent> ge :GscopeFind e <C-R><C-W><cr>
nnoremap <silent> gf :GscopeFind f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <silent> gi :GscopeFind i <C-R>=expand("<cfile>")<CR><CR>
nnoremap <silent> ga :GscopeFind a <C-R><C-W><CR>
nnoremap <silent> gc :GscopeFind c <C-R><C-W><CR>
nnoremap <silent> gC :GscopeFind d <C-R><C-W><CR>

"       gutentags_plus ------------{{{

if general#only_use_static_tag
	nnoremap <silent> gs :GscopeFind s <C-R><C-W><CR>:cnext<CR>zz
	nnoremap <silent> gd :GscopeFind g <C-R><C-W><CR>:cnext<CR>zz
    nnoremap <silent> gt :GscopeFind t <C-R><C-W><CR>:cnext<CR>zz
endif

nnoremap <C-g> :GtagsCursor<CR>zz

" Don't change focus to quickfix window after search
let g:gutentags_plus_switch = 0
" Disable default mapping
let g:gutentags_plus_nomap = 1

" Gtags is not installed
if &csprg != 'gtags-cscope'
    nnoremap <silent> ge :echoerr 'gtags-scope is not available'<CR>
    nnoremap <silent> gf :echoerr 'gtags-scope is not available'<CR>
    nnoremap <silent> gi :echoerr 'gtags-scope is not available'<CR>
    nnoremap <silent> ga :echoerr 'gtags-scope is not available'<CR>
    nnoremap <silent> <C-g> :echoerr 'gtags-scope is not available'<CR>
    nnoremap <silent> gc :echoerr 'gtags-scope is not available'<CR>
    nnoremap <silent> gC :echoerr 'gtags-scope is not available'<CR>
    if general#only_use_static_tag
        nnoremap <silent> gt :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gs :echoerr 'gtags-scope is not available'<CR>
        nnoremap <silent> gd :echoerr 'gtags-scope is not available'<CR>
    endif
endif
" --------------}}}

" tagbar{{{
let g:tagbar_show_linenumbers = 0
let g:tagbar_compact = 1
let g:tagbar_wrap = 1
let g:tagbar_autofocus = 1
nnoremap <silent> [ov :call <SID>open_tagbar()<CR>
nnoremap <silent> ]ov :TagbarClose<CR>
nnoremap <silent> yov :call <SID>toggle_tagbar()<CR>

function s:open_tagbar() abort
    let g:tagbar_width = min([80, winwidth(0) / 3 + 5])
    TagbarOpen
endfunction

function s:toggle_tagbar() abort
    let g:tagbar_width = min([80, winwidth(0) / 3 + 5])
    TagbarToggle
endfunction
"}}}

" -----------}}}

" AutoFormat{{{
" use lua-format as default lua formatter
let g:formatdef_my_custom_lua = 'lua-format -i'
let g:formatter_lua = ['my_custom_lua']
nnoremap <Leader>bf :Autoformat<CR>
"}}}

" autopairs{{{

let g:AutoPairsShortcutToggle = ''          " disable shortcut
"}}}

" vim-floaterm{{{

if general#is_windows && executable('bash')
    let g:floaterm_shell = exepath('bash')
endif
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
" vim-quickiui is a simple ui for terminal vim, but I only use it to preview
" tag in pop up window.
if has('patch-8.1.2292') == 0 && exists('*nvim_open_win') == 0
	echoerr "vim-quickui can't work"
else
	nnoremap <silent> <localleader>p :call quickui#tools#preview_tag('')<CR>
	nnoremap <silent> <localleader>j :call quickui#preview#scroll(5)<CR>
	nnoremap <silent> <localleader>k :call quickui#preview#scroll(-5)<CR>
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
command! TaskEdit exec 'vsp ' .. general#vimfiles .. '/tasks.ini'
" Run program in tab
let g:asynctasks_term_pos = 'tab'
" Set quickfix window height
let g:asyncrun_open = 10
" Bell when task finished
let g:asyncrun_bell = 1
" Set root makers of project
let g:asyncrun_rootmarks = general#project_root_makers

" They will slow down <C-I> because <Tab> equals to <C-I>
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

" Display translation in a window
nmap <silent> <Leader>tw <Plug>TranslateW
vmap <silent> <Leader>tw <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <Leader>tr <Plug>TranslateR
vmap <silent> <Leader>tr <Plug>TranslateRV
" Translate the text in clipboard
nmap <silent> <Leader>tx <Plug>TranslateX
"}}}

" leetcode{{{

let g:leetcode_solution_filetype = ['c', 'cpp', 'rust']
let g:leetcode_browser = 'firefox'
let g:leetcode_china = 1
"}}}

let g:lightline = {
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified'], ['gitbranch', 'gutentags']],
            \   'right': [['lineinfo'], ['percent'], ['readonly'], ['cocstatus'], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]]
            \ },
            \ 'component_function': {
            \   'gutentags': 'gutentags#statusline',
            \   'gitbranch': 'FugitiveHead',
            \ },
            \ 'component_type': {
            \   'readonly': 'error',
            \ },
            \ }
autocmd User CocStatusChange call lightline#update()
autocmd User GutentagsUpdated,GutentagsUpdating call lightline#update()
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = '💡'
let g:lightline#ale#indicator_warnings = '⚠️'
let g:lightline#ale#indicator_errors = '✖'
let g:lightline#ale#indicator_ok = "\uf00c"

" }}}

" color scheme {{{
if strftime("%H") <= 18
    let g:github_colors_soft = 1
    set background=light
    colorscheme github
    let g:lightline.colorscheme = 'github'
else
    let g:edge_style = 'neon'
    let g:edge_better_performance = 1
    set background=dark
    colorscheme edge
    let g:lightline['colorscheme'] = 'edge'
endif
" }}}

" vim-mam{{{
nnoremap gm :Vman 3 <C-r><C-w><CR>
nnoremap gk :vertical help <C-r><C-w><CR>
"}}}

" vimspector setting{{{
nnoremap <silent> <F1> :call vimspector#Stop()<CR>
nnoremap <silent> <F2> :call vimspector#Restart()<CR>
nnoremap <silent> <F3> :call vimspector#Continue()<CR>
nnoremap <silent> <F4> :call vimspector#Pause()<CR>
nnoremap <silent> <F5> :call vimspector#RunToCursor()<CR>
nnoremap <silent> <F6> :call vimspector#ToggleBreakpoint()<CR>
nnoremap <silent> <Leader><F6> :call vimspector#ListBreakpoints()<CR>
nnoremap <silent> <F7> :call <SID>toogle_conditional_breakpoint()<CR>
nnoremap <silent> <F8> :call vimspector#StepOver()<CR>
nnoremap <silent> <F9> :call vimspector#StepInto()<CR>
nnoremap <silent> <F10> :call vimspector#StepOut()<CR>

nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval

function! s:toogle_conditional_breakpoint()
    let l:condition = trim(input("Condition: "))
    if empty(l:condition)
        return
    endif
    let l:count = trim(input("Count: "))
    if empty(l:count)
        let l:count = 1
    else
        let l:count = str2nr(l:count)
    endif
    call vimspector#ToggleBreakpoint({'condition': l:condition, 'hitCondition': l:count})
endfunction

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
let g:NERDAltDelims_asm = 1
let g:NERDCreateDefaultMappings = 0

" It is impossible to determine execute mode in hooks. Thus, I wrap raw NERDComment()
" to pass mode infomation to hooks and create mappings manually.
"
" NERDCommenterAltDelims is not wrapped and it would execute hooks. So I
" delete variable g:NERDCommenter_mode in NERDCommenter_after() to disable
" hooks executed by NERDCommenterAltDelims
function! s:NERDCommenter_wrapper(mode, type) range
    let g:NERDCommenter_mode = a:mode
    execute a:firstline .. ','  .. a:lastline 'call NERDComment(' .. string(a:mode) .. ',' .. string(a:type) .. ')'
endfunction

" modes: a list of mode(n - normal, x - visual)
function! s:create_commenter_mapping(modes, map, type)
    for l:mode in split(a:modes, '\zs')
        execute l:mode .. 'noremap <silent> <Leader>' .. a:map .. ' :call <SID>NERDCommenter_wrapper(' .. string(l:mode) .. ', ' .. string(a:type) .. ')<CR>'
    endfor
endfunction

function! CreateCommenterMappings()
    " All mappings are equal to standard NERDCommenter mappings.
    call s:create_commenter_mapping('nx', 'cc', 'Comment')
    call s:create_commenter_mapping('nx', 'cu', 'Uncomment')
    call s:create_commenter_mapping('n', 'cA', 'Append')
    call s:create_commenter_mapping('nx', 'c<space>', 'Toggle')
    call s:create_commenter_mapping('nx', 'cm', 'Minimal')
    call s:create_commenter_mapping('nx', 'cn', 'Nested')
    call s:create_commenter_mapping('n', 'c$',  'ToEOL')
    call s:create_commenter_mapping('nx', 'ci', 'Invert')
    call s:create_commenter_mapping('nx', 'cs', 'Sexy')
    call s:create_commenter_mapping('nx', 'cy', 'Yank')
    call s:create_commenter_mapping('n', 'cA',  'Append')
    call s:create_commenter_mapping('nx', 'cl', 'AlignLeft')
    call s:create_commenter_mapping('nx', 'cb', 'AlignBoth')
    call s:create_commenter_mapping('nx', 'cu', 'Uncomment')
    call s:create_commenter_mapping('n', 'ca',  'AltDelims')
    nmap <leader>ca <plug>NERDCommenterAltDelims
endfunction

" NERDCommenter hooks
function! NERDCommenter_before()
    let g:nerdcommmenter_visual_flag = v:false
    if get(g:, 'NERDCommenter_mode', '') =~# '[vsx]'    " executed in visual mode
        let l:marklist = getmarklist('%')
        for l:mark in l:marklist
            if l:mark['mark'] =~ "'>"
                let g:nerdcommmenter_cursor = l:mark.pos
                let g:nerdcommmenter_visual_flag = v:true
                break
            endif
        endfor
    endif
endfunction

function! NERDCommenter_after()
    if g:nerdcommmenter_visual_flag
        call setpos('.', g:nerdcommmenter_cursor)
    endif
    let g:nerdcommmenter_visual_flag = v:false
    unlet! g:NERDCommenter_mode
endfunction

" }}}

" nerdtree {{{
let NERDTreeRespectWildIgnore = 1
let NERDTreeMinimalUI = 1
let NERDTreeCascadeOpenSingleChildDir = 1
nnoremap <silent> <Leader>to :call tools#nerdtree_toggle_outermost_dir()<CR>
nnoremap <silent> <Leader>ti :call tools#nerdtree_toggle_innermost_dir()<CR>
nnoremap <silent> <leader>tt :call tools#nerdtree_toggle_root()<CR>
nnoremap <silent> <leader>tc :call tools#nerdtree_close()<CR>

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
let doge_doc_standard_c = 'doxygen_javadoc'
let doge_doc_standard_cpp = 'doxygen_javadoc'
let g:doge_mapping_comment_jump_forward = '<C-j>'
let doge_mapping_comment_jump_backward = '<C-k'
"}}}

" vim-sandwich {{{
runtime macros/sandwich/keymap/surround.vim
" }}}

" accelerated-jk {{{
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
" }}}

" abbreviation{{{
iabbrev rn return
iabbrev today <C-r>=strftime("%Y-%m-%d")<CR>
" }}}

" nvim-treesitter and textobjects {{{
if general#nvim_is_latest
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'c', 'cpp', 'toml', 'json', 'lua', 'python', 'bash', 'rust'},
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["am"] = "@comment.outer",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
      }
    }
  }
}
-- integrate with rainbow
require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
EOF
else
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
endif

"}}}

" match-up {{{
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}
let g:matchup_matchpref = {'cpp': {'template': 1}}
"}}}

" vim-auto-popmenu {{{
let g:apc_enable_ft = {'text':1, 'markdown':1, 'gitcommit': 1, 'vimwiki': 1}
" }}}

" editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}}

" vim-terminal-help {{{
let g:terminal_cwd = 0
" }}}

" lens.vim {{{
let g:lens#disabled_filetypes = ['nerdtree', 'list', 'gitcommit', 'fugitive', 'man', 'tagbar', 'qf', '', 'help', 'diff', 'undotree', 'leaderf']
let g:lens#disabled_buftypes = ['nofile', '', 'terminal']
" }}}

" TrueZen.nvim {{{
" Called by dein.vim
function ConfigureTrueZen()
lua << EOF
-- setup for TrueZen.nvim
require("true-zen").setup({

    true_false_commands = false,
	cursor_by_mode = false,
	bottom = {
		hidden_laststatus = 0,
		hidden_ruler = false,
		hidden_showmode = false,
		hidden_showcmd = false,
		hidden_cmdheight = 1,

		shown_laststatus = 2,
		shown_ruler = true,
		shown_showmode = false,
		shown_showcmd = false,
		shown_cmdheight = 1
	},
	top = {
		hidden_showtabline = 0,

		shown_showtabline = 2
	},
	left = {
		hidden_number = false,
		hidden_relativenumber = false,
		hidden_signcolumn = "no",

		shown_number = true,
		shown_relativenumber = false,
		shown_signcolumn = "no"
	},
	ataraxis = {
		left_right_padding = 40
	},
    integrations = {
        integration_gitgutter = true
    }
})
EOF
endfunction
" }}}

" numb.vim {{{
function ConfigureNumb()
lua <<EOF
require('numb').setup()
EOF
endfunction
" }}}

" ALE {{{
let g:ale_disable_lsp = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠️'
let g:ale_sign_info = '💡'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_c_parse_compile_commands = 1
let g:ale_c_parse_makefile = 1
let g:ale_cpp_cc_options = '-std=c++17 -Wall'
let g:ale_linters_explicit = 1 " Disable other linters
let g:ale_lint_on_text_changed = 'never' " Only lint when save and leave insert
let g:ale_lint_on_insert_leave = 1
nmap <silent> gN <Plug>(ale_previous_wrap)
nmap <silent> gn <Plug>(ale_next_wrap)
" }}}

