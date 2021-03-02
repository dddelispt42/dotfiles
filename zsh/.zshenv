# test -s /etc/zprofile && source /etc/zprofile || true
test -s $HOME/.config/shell/env.sh && source $HOME/.config/shell/env.sh || true
test -s $ZDOTDIR/zshrc && source $ZDOTDIR/zshrc || true
