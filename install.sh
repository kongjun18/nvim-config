VIM="${HOME}/.vim"
NVIM="${HOME}/.config/nvim"
VIMRC="${HOME}/.vimrc"
NVIMRC="${NVIM}/init.vim"

 
if [ -d ${VIM} -o -L ${VIM} ] ; then
	echo "mv ${VIM} ${VIM}.backup"
	mv ${VIM} ${VIM}.backup
fi

if [ -f ${VIMRC} -o -L ${VIMRC} ]; then
	echo "mv ${VIMRC} ${VIMRC}.backup"
	mv ${VIMRC} ${VIMRC}.backup
fi

if [ ! -d ${NVIM} -a ! -L ${NVIM} ]; then
	mkdir -p ~/.config/nvim
fi

if [ -d ${NVIM} -o -L ${NVIM} ]; then
	echo "mv ${NVIM} ${NVIM}.backup"
	mv ${NVIM} ${NVIM}.backup
fi

echo "mv $(pwd)/nvim-config ${NVIM}"
mv $(pwd)/nvim-config ${NVIM}

echo "ln -s ${NVIM} ${VIM}"
ln -s ${NVIM} ${VIM}

echo "ln -s ${NVIMRC} ${VIMRC}"
ln -s ${NVIMRC} ${VIMRC}

echo "ln -s ~/.gvimrc ~/.config/nvim/gvimrc"
ln -s ~/.gvimrc ~/.config/nvim/gvimrc

sh ${NVIM}/tools/dein.sh ${NVIM}/plugged


