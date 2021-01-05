# only if interactive shell
[[ $- == *i* ]] && stty -ixon -ixoff # turns off CTRL-S

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# some history related settings
HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zhistory       # enable history saving on shell exit
setopt APPEND_HISTORY          # append rather than overwrite history file.
setopt SHARE_HISTORY          # append rather than overwrite history file.
HISTSIZE=12000                 # lines of history to maintain memory
SAVEHIST=10000                 # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information
# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# zplug
source ~/.zplug/init.zsh
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh
zplug "ael-code/zsh-colored-man-pages", defer:2
zplug "popstas/zsh-command-time", defer:2
zplug "zdharma/fast-syntax-highlighting", defer:2
# zplug "mafredri/zsh-async", from:"github", use:"async.zsh"
zplug "seletskiy/zsh-fuzzy-search-and-edit"
zplug "andrewferrier/fzf-z"
# zplug "gerges/oh-my-zsh-jira-plus", defer:2
# zplug "micrenda/zsh-nohup", defer:2
zplug "b4b4r07/emoji-cli", defer:2
# zplug "MichaelAquilina/zsh-autoswitch-virtualenv", defer:2
zplug 'wfxr/forgit', defer:2
# zplug 'jedahan/ripz', defer:2
zplug "MichaelAquilina/zsh-you-should-use", defer:2
# use Alt-e to launch a finder
zplug 'leophys/zsh-plugin-fzf-finder', defer:2
# zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
# zplug "romkatv/powerlevel10k", as:theme, depth:1
# let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

# TODO: generate path name
test -s ~/.config/shell/env.sh && source ~/.config/shell/env.sh || true
test -s ~/.config/shell/functions.sh && source ~/.config/shell/functions.sh || true
test -s ~/.config/shell/ssh_agent.sh && source ~/.config/shell/ssh_agent.sh || true
test -s ~/.config/shell/alias.sh && source ~/.config/shell/alias.sh || true
test -s ~/.config/shell/fuzzy_functions.sh && source ~/.config/shell/fuzzy_functions.sh || true
test -s ~/.config/shell/keybinding.sh && source ~/.config/shell/keybinding.sh || true
test -s ~/.config/zsh/svn_prompt.sh && source ~/.config/zsh/svn_prompt.sh || true
test -s ~/.fzf/shell/key-bindings.zsh && source ~/.fzf/shell/key-bindings.zsh || true
test -s ~/.fzf/shell/completion.zsh && source ~/.fzf/shell/completion.zsh || true
test -s /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/key-bindings.zsh || true
test -s /usr/share/fzf/completion.zsh && source /usr/share/fzf/completion.zsh || true

# enable VI mode
bindkey -v
export KEYTIMEOUT=1
# edit line in vim buffer - ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
bindkey ' ^?' backward-delete-char

# include host specific settings
test -s ~/.zshrc.local && source ~/.zshrc.local || true
test -s ~/.config/zshrc.local && source ~/.config/zshrc.local || true

test -s /home/heiko/.config/broot/launcher/bash/br && source /home/heiko/.config/broot/launcher/bash/br || true
eval "$(starship init zsh)"
