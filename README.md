# My configuration of (Neo)vim
Github: https://github.com/kongjun18/nvim-config.git

Gitee: https://github.com/kongjun18/nvim-config.git

The repository is my personal configuration of (Neo)vim based on UNIX.

If you want a community-driven configuration, please see [Spacevim](https://github.com/SpaceVim/SpaceVim).

## Feature
I use (Neo)vim edit almost any files. My (Neo)vim is configured for C/C++, Rust, shell, vimL, json and markdown. It support Vim and Neovim and can run on any GNU/Linux distributions and FreeBSD.

## Requirement
Compulsory:
- Vim 8.1.2269+ or Neovim 4.4+ with python3 support
- Node 10.12:          for coc.nvim
- clangd:              C++ LSP
- rust-analyzer:       Rust LSP
- curl or wget:        downloader used by dein.nvim
- git:                 downloader used by dein.nvim
- gcc, make and CMake: build YouCompleteMe
- Python3.6+:          for YouCompleteMe, Ultisnips and other plugins
- universal ctags:     generate tag file

Optional:
- Latest **Neovim** with python3 and lua support
- rg(ripgrep):  a better grep
- fd:           a faster find
- gtags:        find reference, included file and so on
- pygments:     extend gtags' functionality
- clang-format: format C/C++ code
- cppcheck:     additional linter for C/C++
- shellcheck:   linter for sh and bash
- compiledb:    generate compile database for Makefile
- axel:         a multi-threaded downloader 


By default, my configuration uses coc.nvim to complete and lint source code. If you want to use YouCompleteMe and ale, please set `g:YCM_enabled` defined in vimrc to 1.

## Installation
Clone it, run sh install.sh in shell and then open (Neo)vim.
```sh
git clone https://github.com/kongjun18/nvim-config.git --depth=1
cd nvim-config
sh install.sh
```
(Neo)vim will install dein.nvim and other plugins automatically.

By default, my configuration only enables YouCompleteMe support for C/C++. If you want to enable Rust support, go to path of YouCompleteMe and run install.py.
```sh
cd ~/.config/nvim/plugged/repos/gitee.com/mirrors/youcompleteme
python3 install.py --rust-completer
```
# Problem and Solution
1. YouCompleteMe warnning: "requires Vim compiled with Python (3.6.0+) support."
It is because your Vim without Python3.6.0+ support. 
Please compile your Vim with python3 support or install pynvim using `pip3 install pynvim`.

2. YouCompleteMe warnning: "No module named 'ycmd'"
It is because you have not compile YCM.
Pleease go to the directory YCM resides and run:
```sh
git submodule update --init --recursive
python3 install.py --clangd-completer
```
3. Errors about python3 on neovim
```sh
pip3 install pynvim

