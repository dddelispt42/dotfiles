CACHEDIR="${XDG_CACHE_HOME:-$HOME/.cache}"
SSHDIR="$HOME/.ssh"
if [ "$(pgrep -u "${UID:-$USER}" ssh-agent)" = "" ]; then
    test -e "$CACHEDIR/sshagent.sh" && rm -f "$CACHEDIR/sshagent.sh"
    ssh-agent | grep -v echo > "$CACHEDIR/sshagent.sh"
    # shellcheck source=/home/heiko/.cache/sshagent.sh
    source "$CACHEDIR/sshagent.sh"
    for key in $(fd 'id_*' -a --exclude '*.pub' "$SSHDIR"); do
	# already added?
        if ! ssh-add -L | grep "$(awk '{print $2};' "${key}.pub")" > /dev/null; then
            # only load unencrypted keys
            if [ "$(wc -l ${key} | awk '{print $1;}')" -eq "8" ]; then
                ssh-add "$key"
            fi
            # only for RSA keys
            # if ! grep "ENCRYPTED$" "$key" > /dev/null; then
            #     ssh-add "$key"
            # fi
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
    ssh-keygen -t ed25519 -C "$(whoami)@$(cat /etc/hostname)-$(date -I) -a 100"
}
alias keylist="ssh-add -L"

