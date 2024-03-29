# shellcheck disable=2148
bindkey '\e.' insert-last-word    # Esc-. to insert last word from prev cmd
bindkey '^P' up-line-or-history   # Ctrl-P to scroll up history
bindkey '^N' down-line-or-history # Ctrl-N to scroll down history
bindkey '^[[A' fzf-history-widget # Ctrl-R to reverse search history w/ fzf
# bindkey '^A' fzf-history-widget # Ctrl-A jump to beginning of line
# bindkey '^E' fzf-history-widget # Ctrl-E jump to end of line
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey -s '^[x' 'fconf\n'      # Alt-X to edit a config file
bindkey '^H' backward-kill-word # Ctrl-Backspace to delete previous word
bindkey '^[[3;5~' kill-word     # Ctrl-Del to delete next word
