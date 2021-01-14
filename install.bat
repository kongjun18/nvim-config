set VIMFILES=%HOME%\vimfiles
set VIMRC=%HOME%\_vimrc
set GVIMRC=%HOME%\_gvimrc

if exist %VIMFILES% (
    copy /y %VIMFILES% vimfiles.backup
    del %VIMFILES%
)

if exist %VIMRC% (
    copy /y %VIMRC% _vimrc.backup
    del %VIMRC%
)

if exist %GVIMRC% (
    copy /y %GVIMRC% _gvimrc.backup
    del %GVIMRC%
)

rename nvim-config vimfiles
mklink %VIMRC% %VIMFILES%\init.vim
mklink %GVIMRC%  %VIMFILES%\gvimrc 
powershell.exe -file %VIMFILES%\tools\dein.ps1 %VIMFILES%\plugged
