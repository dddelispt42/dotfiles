# test -s /etc/zprofile && source "$_" || true
test -s $HOME/.config/shell/env.sh && source "$_" || true
test -s $ZDOTDIR/zshrc && source "$_" || true
