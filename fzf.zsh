# Setup fzf
# ---------
if [[ "$OSTYPE" == "darwin"* ]]; then

  if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
  fi

  # export FZF_BASE="$(dirname "$(which fzf)")"
  export FZF_BASE="/opt/homebrew/opt/fzf"

  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

  # Key bindings
  # ------------
  source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

else

# Append this line to ~/.zshrc to enable fzf keybindings for Zsh:

source /usr/share/doc/fzf/examples/key-bindings.zsh

# Append this line to ~/.zshrc to enable fuzzy auto-completion for Zsh:

source /usr/share/doc/fzf/examples/completion.zsh

fi
