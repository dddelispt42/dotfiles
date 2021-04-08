CACHEDIR="${XDG_CACHE_HOME:-$HOME/.cache}"
SSHDIR="$HOME/.ssh"
if [ "$(pgrep -u "$USER" ssh-agent)" = "" ]; then
    test -e "$CACHEDIR/sshagent.sh" && rm -f "$CACHEDIR/sshagent.sh"
    ssh-agent | grep -v echo > "$CACHEDIR/sshagent.sh"
    # TODO: load non-password keys automatically and pw keys interactively
    for key in $(fd 'id_*' -a --exclude '*.pub' "$SSHDIR"); do
        if \! ssh-add -L | grep "$(awk '{print $2};' "${key}.pub")" > /dev/null; then
            ssh-add "$key"
        fi
    done
fi
if [ -e "$CACHEDIR/sshagent.sh" ]; then
    # shellcheck source=/home/heiko/.cache/sshagent.sh
    source "$CACHEDIR/sshagent.sh"
fi

keyadd() {
    local selected
    if selected="$(for key in $(fd 'id_*' -a --exclude '*.pub' "$SSHDIR"); do if ! ssh-add -L | grep "$(awk '{print $2};' "$key.pub")" > /dev/null; then echo "$key"; fi; done | fzf -x -0)"; then
        ssh-add "$selected"
    fi
}
keyremove() {
    ssh-add -d "$(ssh-add -L | sed -e 's/.* //' | fzf -x)"
}
keynew() {
    ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)"
}
alias keylist="ssh-add -L"

