echo "Copying vim files in to place"
xcopy %USERPROFILE%\.dotfiles\vim %USERPROFILE%\vimfiles /E
xcopy %USERPROFILE%\.dotfiles\vimrc %USERPROFILE%\_vimrc /E
