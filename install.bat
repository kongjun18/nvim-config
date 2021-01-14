set VIMFILES=%HOME%\vimfiles
set VIMRC=%HOME%\_vimrc
set GVIMRC=%HOME%\_gvimrc

if exist %VIMFILES% (
    echo rename %VIMFILES% to %VIMFILES%.backup
    rename %VIMFILES% vimfiles.backup
    md %VIMFILES%
)

if exist %VIMRC% (
    echo rename %VIMRC% to %VIMRC%.backup
    rename %VIMRC% _vimrc.backup
)

if exist %GVIMRC% (
    echo rename %GVIMRC% to %GVIMRC%.backup
    rename %GVIMRC% _gvimrc.backup
)

xcopy %cd% %VIMFILES% /s/e/i
copy %cd%\init.vim %VIMRC%
copy %cd%\gvimrc %GVIMRC%
%cd%\tools\dein.ps1 %VIMFILES%\plugged
