if command -v theme.sh >/dev/null; then
	[ -e "${XDG_CONFIG_HOME}/.theme_history" ] && theme.sh "$(theme.sh -l | tail -n1)"

	# Optional

	# Bind C-o to the last theme.
	last_theme() {
		theme.sh "$(theme.sh -l | tail -n2 | head -n1)"
	}
	# last_theme

	zle -N last_theme
	bindkey '^O' last_theme

	alias th='theme.sh -i'

	# Interactively load a light theme
	alias thl='theme.sh --light -i'

	# Interactively load a dark theme
	alias thd='theme.sh --dark -i'
fi
