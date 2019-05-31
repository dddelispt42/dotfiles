function create_dotfile_link {
    if [ -f "$2" ] || [ -d "$2" ]; then
        if [ "$(realpath $1)" = "$(realpath $2)" ]; then
            return
        fi
        mv "$2" "$2.dotfiles-$(date -I)"
    fi
    ln -sf "$1" "$2"
}


