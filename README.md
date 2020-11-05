# My configuration of (Neo)vim
Github: https://github.com/kongjun18/nvim-config.git

Gitee: https://github.com/kongjun18/nvim-config.git

The repository is my personal configuration based on UNIX.

If you want a community-driven configuration, please see [Spacevim](https://github.com/SpaceVim/SpaceVim).

## Prerequisite
Compulsory:
- Vim 8.1.2269+ or Neovim 4.0+ with python3 support
- Node 10.12
- curl:                download dein.vim
- gcc, make and CMake: build YouCompleteMe
- Python3.6+:          for YouCompleteMe, Ultisnips and other plugins
- universal ctags:     generate tag file

Optimal:
- Latest Vim or Neovim with python3 support
- rg(ripgrep):  a better grep
- fd:           a faster find
- gtags:        find reference, included file and so on
- pygments:     extend gtags' functionality
- clang-format: format C/C++ code
- cppcheck:     additional linter for C/C++
- shellcheck:   linter for vimL
- compiledb:    generate compile database for Makefile

## Installation
Clone it, run sh install.sh in shell and then open (Neo)vim.
```sh
git clone https://github.com/kongjun18/nvim-config.git --depth=1
cd nvim-config
sh install.sh
```
(Neo)vim will download dein.vim and install plugins automatically.

By default, my configuration enables YouCompleteMe support for C/C++. If you want to enable Rust support, go to YouCompleteMe path and run install.py.
```sh
cd ~/.config/nvim/plugged/repos/gitee.com/mirrors/youcompleteme
python3 install.py --rust-completer
```
**Note**: On some GNU/Linux distribution(such as Debian10.2), you need set `g:ycm_clangd_binary_path` manually. For example:
```vim
let g:ycm_clangd_binary_path = '/usr/bin/clangd-10'
```
# Problem and Solution
1. YouCompleteMe warnning: "requires Vim compiled with Python (3.6.0+) support."
It is because your Vim without Python3.6.0+ support. 
Please compile your Vim with python3 support or install pynvim using `pip3 install pynvim`.

2. YouCompleteMe warnning: "No module named 'ycmd'"
It is because you have not compile YCM.
Pleease go to the directory YCM resides and run:
```
git submodule update --init --recursive
python3 install.py --clangd-completer
```
