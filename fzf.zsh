if [[ "$OSTYPE" == "darwin"* ]]; then
		# Mac OSX
		# Setup fzf
		# ---------
		if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
				export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
		fi

		# Auto-completion
		# ---------------
		[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

		# Key bindings
		# ------------
		source "/usr/local/opt/fzf/shell/key-bindings.zsh"
else
		export FZF_BASE="$(dirname "$(which fzf)")"
fi
