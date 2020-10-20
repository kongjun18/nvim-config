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

echo "mkdir -p ${NVIM}"
mkdir -p ${NVIM}

echo "cp -r $(pwd)/* ${NVIM}"
cp -r $(pwd)/* ${NVIM}

echo "ln -s ${NVIM} ${VIM}"
ln -s ${NVIM} ${VIM}

echo "ln -s ${NVIMRC} ${VIMRC}"
ln -s ${NVIMRC} ${VIMRC}



