@ECHO OFF
REM install and update  chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
REM install packages
choco install librewolf bat fd starship garmin wget
REM download librewolf pluins:
REM - bitwarden
REM - firenvim
REM - ublock origin
REM - linkding
REM - vimium
cd $HOME/Downloads
wget "https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/"
wget "https://addons.mozilla.org/en-US/firefox/addon/firenvim/"
wget "https://addons.mozilla.org/en-US/firefox/addon/linkding-extension/"
wget "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/"
wget "https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/"
wget "https://addons.mozilla.org/en-US/firefox/addon/floccus/"
wget "https://addons.mozilla.org/en-US/firefox/addon/single-file/"
wget "https://addons.mozilla.org/en-US/firefox/addon/clickbait-remover-for-youtube/"
wget "https://addons.mozilla.org/en-US/firefox/addon/auto-tab-discard/"
wget "https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/"
wget "https://addons.mozilla.org/en-US/firefox/addon/leechblock-ng/"
