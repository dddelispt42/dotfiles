if [ "$(pgrep -u "$USER" ssh-agent)" = "" ]; then
    test -e "$HOME/.cache/sshagent.sh" && rm -f "$HOME/.cache/sshagent.sh"
    ssh-agent | grep -v echo > "$HOME/.cache/sshagent.sh"
fi
test -e "$HOME/.cache/sshagent.sh" && . "$HOME/.cache/sshagent.sh"

keyadd() {
    ssh-add $(diff <(ssh-add -L | sed -e 's/.* //'|sort) <(\ls "$HOME"/.ssh/*id_* | grep -v "\.pub$"|sort) | grep --color=no -E "[<>] " | sed -e "s/[<>] //" | fzf -x)
}
keyremove() {
    ssh-add -d "$(ssh-add -L | sed -e 's/.* //' | fzf -x)"
}
keynew() {
    ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)"
}
alias keylist="ssh-add -L"

