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

if [ -d ${NVIM} -o -L ${NVIM} ]; then
	echo "mv ${NVIM} ${NVIM}.backup"
	mv ${NVIM} ${NVIM}.backup
fi

git clone https://github.com/kongjun18/nvim-config.git
echo "mv $(pwd)/nvim-config ${NVIM}"
mv $(pwd)/nvim-config ${NVIM}

echo "ln -s ${NVIM} ${VIM}"
ln -s ${NVIM} ${VIM}

echo "ln -s ${NVIMRC} ${VIMRC}"
ln -s ${NVIMRC} ${VIMRC}

sh ${NVIM}/tools/dein.sh ${NVIM}/plugged


