#! /bin/bash
#
# Install neovim-6.0, C/C++, Javascript and Lua development dependencies.
# The script is only tested on Debian11.

apt install -y fuse # support appimage
wget https://hub.fastgit.org/neovim/neovim/releases/download/v0.6.0/nvim.appimage
chmod a+x nvim.appimage
mv nvim.appimage /usr/local/bin/nvim
# Neovim plugins dependencies
apt install -y git gcc make python3 pip nodejs npm
npm install -g yarn
pip3 install pynvim
# Tag system
apt install -y global universal-ctags
pip3 install -y pygments
# C++ development
apt install -y ccls cmake gdb clang-format clang-tidy bear doxygen graphviz
pip3 install cmake-language-server
# Lua development
apt install -y unzip luarocks
wget https://hub.fastgit.org/JohnnyMorganz/StyLua/releases/download/v0.11.2/stylua-0.11.2-linux.zip -O /tmp/stylua.zip \
    && unzip -o /tmp/stylua.zip -d /usr/local/bin \
    && chmod a+x /usr/local/bin/stylua
luarocks install ldoc luacheck
# Javascript development
npm install -g eslint standard jsdoc
# Bash shell
apt install -y shellcheck
# System utilites
apt install -y ripgrep fd-find
