# My configuration of (Neo)vim
Github: https://github.com/kongjun18/nvim-config.git

Gitee: https://github.com/kongjun18/nvim-config.git

The repository is my personal configuration based on UNIX.

If you want a community-driven configuration, please see [Spacevim](https://github.com/SpaceVim/SpaceVim).

## Prerequisite
Compulsory:
- Vim 8.0 or Neovim 4.0 with python3 support
- curl:                download dein.vim
- gcc, make and CMake: build YouCompleteMe
- Python3.6+:          for YouCompleteMe, Ultisnips and other plugins
- universal ctags:     generate tag file

Optimal:
- Vim 8.2+ or Neovim 5.0+ with python3 support
- rg(ripgrep):  a better grep
- fd:           a faster find
- gtags:        find reference, included file and so on
- pygments:     extend gtags' functionality
- clang-format: format C/C++ code
- cppcheck:     additional linter for C/C++
- shellcheck:   linter for vimL

## Installation
Clone it, run sh install.sh in shell and then open (Neo)vim.
```sh
git clone https://github.com/kongjun18/nvim-config.git --depth=1
cd nvim-config
sh install.sh
```
(Neo)vim will download dein.vim and install plugins automatically.

By default, my configuration only enable YouCompleteMe support for C/C++. If you want to enable Rust support, go to YouCompleteMe path and run install.py.
```sh
cd ~/.config/nvim/plugged/repos/gitee.com/mirrors/youcompleteme
python3 install.py --rust-completer
```


