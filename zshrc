DISABLE_AUTO_UPDATE="true"
DISABLE_COMPFIX="true"

autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# zmodload zsh/zprof

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE

# Immediately append to history file:
setopt INC_APPEND_HISTORY

# Record timestamp in history:
setopt EXTENDED_HISTORY

# Expire duplicate entries first when trimming history:
setopt HIST_EXPIRE_DUPS_FIRST

# Dont record an entry that was just recorded again:
setopt HIST_IGNORE_DUPS

# Delete old recorded entry if new entry is a duplicate:
setopt HIST_IGNORE_ALL_DUPS

# Do not display a line previously found:
setopt HIST_FIND_NO_DUPS

# Dont record an entry starting with a space:
setopt HIST_IGNORE_SPACE

# Dont write duplicate entries in the history file:
setopt HIST_SAVE_NO_DUPS

# Share history between all sessions:
setopt SHARE_HISTORY

# Execute commands using history (e.g.: using !$) immediatel:
unsetopt HIST_VERIFY

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=:ow=:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#snap
export PATH=$PATH:/snap/bin
export PATH="/opt/homebrew/opt/llvm/bin/:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
eval "$(mise activate zsh)"

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

if [[ -r "/usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
else
  # Set name of the theme to load --- if set to "random", it will
  # load a random theme each time oh-my-zsh is loaded, in which case,
  # to know which specific one was loaded, run: echo $RANDOM_THEME
  # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
  # ZSH_THEME="robbyrussell"
  ZSH_THEME="powerlevel10k/powerlevel10k"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
#
# Set fzf installation directory path
#export FZF_BASE="$(dirname "$(which fzf)")"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# export DISABLE_FZF_KEY_BINDINGS="true"
#
export FZF_DEFAULT_OPTS=--info=inline
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}' --select-1 --exit-0"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window right:hidden:wrap --bind '?:toggle-preview'"
export FZF_TMUX=0

zstyle ':omz:plugins:docker' legacy-completion yes

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf fzf-tab autoupdate zsh-autosuggestions docker zsh-lazyload zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

setopt no_auto_cd
setopt no_cdable_vars

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#export DOCKER_HOST='tcp://0.0.0.0:2375'
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#bindkey -v

export VIMCONFIG=~/.config/nvim
export VIMDATA=~/.local/share/nvim
# Use Neovim as "preferred editor"
export VISUAL=nvim
# Use Neovim instead of Vim or Vi
alias vim=nvim
alias vi=nvim
alias view=nvim

[[ ! -f ~/.paths ]] || source ~/.paths

export LANG="en_US.UTF-8"

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCREEN_SCALE_FACTORS=1


if [[ "$OSTYPE" == "darwin"* ]]; then

update() {
  trap 'echo "Terminating..."; kill 0' SIGINT
  # set -e

  sudo echo "sudo" && \
  echo "[brew update]" && \
  brew update && \
  echo "[upgrade]" && \
  # don't check error code for the next line
  # because some brew dev idiot considered it a good idea
  # to return an error code when there is nothing to upgrade
  brew upgrade || true && \
  echo "[autoremove]" && \
  brew autoremove && \
  echo "[cleanup]" && \
  brew cleanup && \
  echo "[mise upgrade]" && \
  mise upgrade && \
  echo "[pip update]" && \
  pip install --upgrade pip && \
  pip list --outdated --format=json | jq -r '.[].name' | xargs -n1 pip install -U && \
  echo "[pip3 update]" && \
  pip3 install --upgrade pip && \
  pip3 list --outdated --format=json | jq -r '.[].name' | xargs -n1 pip3 install -U && \
  echo "[pip cache cleanup]" && \
  pip cache purge && \
  echo "[pip3 cache cleanup]" && \
  pip3 cache purge && \
  echo "[rustup update]" && \
  rustup update && \
  echo "[cargo update]" && \
  cargo install-update -a && \
  echo "[cargo cache cleanup]" && \
  cargo cache --autoclean && \
  echo "[npm update]" && \
  npx npm-check --global --update-all
  echo "[npm cache cleanup]" && \
  npm cache clean --force && \
  echo "[uv cache cleanup]" && \
  uv cache clean && \
  echo "[tldr update]" && \
  tldr --update
  echo "[oh my zsh update]"
  omz update

  return $?
}

else

export GRADLE_HOME=/opt/gradle/latest
export PATH=${GRADLE_HOME}/bin:${PATH}

update() {
  echo "[apt update]" && \
	  sudo apt update && \
	  echo "[apt upgrade]" && \
	  sudo apt upgrade -y && \
	  echo "[apt autoremove]" && \
	  sudo apt autoremove -y && \
	  echo "[mise upgrade]" && \
	  mise upgrade && \
	  echo "[cargo cache cleanup]" && \
	  cargo cache --autoclean && \
	  echo "[npm cache cleanup]" && \
	  npm cache clean --force && \
	  echo "[uv cache cleanup]" && \
	  uv cache clean && \
	  echo "[pip cache cleanup]" && \
	  pip cache purge && \
	  echo "[rustup update]" && \
	  rustup update && \
	  echo "[cargo install-update -a]" && \
	  cargo install-update -a && \
	  echo "[yt-dlp update]" && \
	  yt-dlp -U && \
      echo "[npm update]" && \
      npx npm-check --global --update-all
	  echo "[tldr update]" && \
	  tldr --update
      echo "[oh my zsh update]"
      omz update
}

fi

alias ll="eza --classify"
alias lm="eza --classify --long --sort=changed"

if [ -e /home/q/.nix-profile/etc/profile.d/nix.sh ]; then . /home/q/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
echo -ne "\033]12;Red1\007"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

#rust
export PATH="$HOME/.cargo/bin:$PATH"
source $HOME/.cargo/env

if [[ "$OSTYPE" == "darwin"* ]]; then

install-rust-things()
{
	if [ ! -f "$HOME/.config/rustlang/autocomplete/rustup" ]; then
		mkdir -p ~/.config/rustlang/autocomplete
		rustup completions bash rustup >> ~/.config/rustlang/autocomplete/rustup
	fi
	source "$HOME/.config/rustlang/autocomplete/rustup"
	if ! command -v rust-analyzer &> /dev/null
	then
		brew install rust-analyzer
	fi
	if ! cargo audit --version &> /dev/null; then
		cargo install cargo-audit --features=fix
	fi
	if ! cargo nextest --version &> /dev/null; then
		cargo install cargo-nextest
	fi
	if ! cargo fmt --version &> /dev/null; then
		rustup component add rustfmt
	fi
	if ! cargo clippy --version &> /dev/null; then
		rustup component add clippy
	fi
	if ! ls ~/.cargo/bin | grep 'cargo-upgrade' &> /dev/null; then
		cargo install cargo-edit
	fi
}

else

install-rust-things()
{
	if [ ! -f "$HOME/.config/rustlang/autocomplete/rustup" ]; then
		mkdir -p ~/.config/rustlang/autocomplete
		rustup completions bash rustup >> ~/.config/rustlang/autocomplete/rustup
	fi
	source "$HOME/.config/rustlang/autocomplete/rustup"
	if ! command -v rust-analyzer &> /dev/null
	then
		mkdir -p ~/.local/bin
		curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
		chmod +x ~/.local/bin/rust-analyzer
	fi
	if ! cargo audit --version &> /dev/null; then
		cargo install cargo-audit --features=fix
	fi
	if ! cargo nextest --version &> /dev/null; then
		cargo install cargo-nextest
	fi
	if ! cargo fmt --version &> /dev/null; then
		rustup component add rustfmt
	fi
	if ! cargo clippy --version &> /dev/null; then
		rustup component add clippy
	fi
	if ! ls ~/.cargo/bin | grep 'cargo-upgrade' &> /dev/null; then
		cargo install cargo-edit
	fi
}

fi

 

FILE="$HOME/.docker/init-zsh.sh"; [[ -f "$FILE" ]] && . "$FILE"

fix-mosh-server() {
  fw=/usr/libexec/ApplicationFirewall/socketfilterfw
  mosh=$(/opt/homebrew/bin/brew info mosh|grep Cellar|awk '{print $1}')/bin/mosh-server
  echo $mosh
  sudo $fw --add $mosh
  sudo $fw --unblockapp $mosh
}

function preexec() {
  local color="242"
  local timestamp
  local ruler_length
  local dots=""

  timestamp=$(print -P -l "%D{%H:%M:%S %Y-%m-%d}")
  (( ruler_length = COLUMNS - ${#timestamp} ))
  (( ruler_length < 0 )) && ruler_length=0

  if (( ruler_length > 0 )); then
    dots=$(printf '·%.0s' {1..$ruler_length})
  fi

  print -P "\n%F{$color}${dots}%D{%H:%M:%S %Y-%m-%d}%f"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
	alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

 


if [[ "$OSTYPE" == "darwin"* ]]; then
    deduplicate_impl()
    {
        join -t ' ' -1 1 -2 1 firsts others | cut -d ' ' -f 2- > duplicates

        # show progress with percentage
        total=$(wc -l < duplicates | tr -d '[:space:]') 
        current=0

        cat duplicates | while read orig dup ;
        do
            count=$((current++))
            percent=$((count * 100 / total))
            echo -n "[$percent% $current of $total]\t"

            #skip empty filenames
            if [ -z "$orig" ]; then
                echo "skipping because orig is empty"
                continue
            fi
            if [ -z "$dup" ]; then
                echo "skipping because dup is empty"
                continue
            fi

            fileSize=$(stat -f%z "$orig")
            dupeSize=$(stat -f%z "$dup")

            echo -n "[size = $fileSize]\t"


            #skip if not a duplicate
            if [ "$fileSize" -ne "$dupeSize" ]; then
                echo "skipping $orig and $dup as they are not the same size"
                continue
            fi
            #skip if cntents differs
            if ! cmp -s "$orig" "$dup"; then
                echo "skipping $orig and $dup as they are not the same"
                continue
            fi
            cp -v -c "$orig" "$dup" || true
        done
    }
        
    deduplicate()
    {
        #brew install rdfind
        rdfind -makeresultsfile true .
        cat results.txt | grep DUPTYPE_FIRST_OCCURRENCE | cut -d ' ' -f 2,8- | sort | perl -pe 's/ (?!\.)/\\ /g' > firsts
        cat results.txt | grep DUPTYPE_WITHIN_SAME_TREE | cut -d ' ' -f 2,8- | cut -c 2- | sort | perl -pe 's/ (?!\.)/\\ /g' > others
        deduplicate_impl
    }
fi


# add ~/bin to PATH
export PATH="$HOME/bin:$PATH"

lazyload zoxide -- 'eval "$(zoxide init zsh)"'

#github copilot cli
lazyload gh -- 'eval "$(gh copilot alias -- zsh)"'

source ~/.secrets

export AIDER_ANALYTICS_DISABLED=True

# zprof

# disable yarn messing with files
export COREPACK_ENABLE_AUTO_PIN=0

# claude code
export DISABLE_TELEMETRY=1
export DISABLE_ERROR_REPORTING=1
alias cc="claude --dangerously-skip-permissions"
alias ccc="claude --dangerously-skip-permissions -p"
alias gcauto='git commit -m "$(claude -p "Look at the staged git changes and create a summarizing git commit title. Only respond with the title and no affirmation.")"'

#jujutsu, jj
source <(COMPLETE=zsh jj)

#codex

cx() {
    if [[ "$1" == "update" ]]; then
        mise upgrade -l npm:@openai/codex@latest

    fi
    codex --yolo --enable web_search_request
}

#gemini

alias gg="gemini --yolo"

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ipad='$HOME/dots/bin/sidecar.swift connect "iPadM1"'
  alias noipad='$HOME/dots/bin/sidecar.swift disconnect "iPadM1"'
fi


# for url pasting
set zle_bracketed_paste
autoload -Uz bracketed-paste-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic

