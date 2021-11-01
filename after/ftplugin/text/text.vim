setlocal wrap           " Wrap line
setlocal spell          " Enable spell checking
setlocal cpt=.,k,w,b    " Source for dictionary, current buffer and other loaded buffers
execute 'setlocal dict=' . general#vimfiles .'/dict/word.dict'
