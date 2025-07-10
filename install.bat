@ECHO OFF

REM only continue in case user has admin rights
AT > NUL
IF %ERRORLEVEL% EQU 0 (
    ECHO you are Administrator
) ELSE (
    ECHO you are NOT Administrator. Exiting...
    PING 127.0.0.1 > NUL 2>&1
    pause
    EXIT /B 1
)

REM Install chocolatey
powershell -command "Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('http://internal/odata/repo/ChocolateyInstall.ps1'))"
REM Install windows apps
choco install 7zip alacritty autohotkey bat cmake delta dokany fd ffmpeg flameshot flow-launcher fzf gimp git graphviz hackfont jq lightshot lua luarocks make mingw neovide neovim pandoc procexp procmon python ripgrep ripgrep-all Sudo sumatrapdf TcpView tree-sitter vlc vnc-viewer wezterm WinDirStat winfetch winscp yazi just
REM Setup dotfiles
if not exist "%HOME%\dev\" mkdir %HOME%\dev
if not exist "%HOME%\dev\heiko\" mkdir %HOME%\dev\heiko
if exist "%HOME%\dev\heiko\dotfiles" git -C %HOME%\dev\heiko\dotfiles up
if not exist "%HOME%\dev\heiko\dotfiles" git clone "https://codeberg.org/hriemer/dotfiles.git" %HOME%\dev\heiko\dotfiles
REM env vars
REM setx BROWSER "C:\" /m
REM setx BROWSER "C:\" /m
REM setx EDITOR "C:\Program Files\Neovide\neovide.exe" /m
setx EDITOR "nvim.exe" /m
REM setx TERMINAL "C:\Program Files\Alacritty\alacritty.exe" /m
setx TERMINAL "C:\Program Files\WezTerm\wezterm-gui.exe" /m
setx YAZI_FILE_ONE "C:\Program Files\Git\usr\bin\file.exe" /m

REM TODO(heiko): autoinstall automount crypt volumes
REM TODO(heiko): autoinstall AHK
REM TODO(heiko): autoinstall startup
REM TODO(heiko): autoinstall backup
