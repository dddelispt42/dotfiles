GREP=grep
test=`ps -ef | $GREP ssh-agent | $GREP -v grep | awk '{print $2}' | xargs`

if [ "$test" = "" ]; then
    # there is no agent running
    if [ -e "$HOME/.agent.sh" ]; then
        # remove the old file
        rm -f "$HOME/.agent.sh"
    fi;
    # start a new agent
    ssh-agent | $GREP -v echo >&$HOME/.agent.sh
fi;

test -e "$HOME/.agent.sh" && source "$HOME/.agent.sh"

function keyadd() {
    ssh-add $(diff <(ssh-add -L | sed -e 's/.* //'|sort) <(\ls $HOME/.ssh/*id_* | grep -v "\.pub$"|sort) | grep --color=no -E "[<>] " | sed -e "s/[<>] //" | fzf -x)
}
function keyremove() {
    ssh-add -d "$(ssh-add -L | sed -e 's/.* //' | fzf -x)"
}
function keynew() {
    ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)"
}
alias keylist="ssh-add -L"


