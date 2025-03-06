if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
[[ -n $TMUX ]] && export TERM="screen-256color"

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

export XDG_CONFIG_HOME="$HOME/.config"
export ZK_NOTEBOOK_DIR="$HOME/Documents/zk"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit ice wait"1" lucid
zinit light laggardkernel/zsh-thefuck
zinit light darvid/zsh-poetry

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# homebrew
HOMEBREW_NO_ENV_HINTS=TRUE

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias add="git add"
alias co="git checkout"
alias cob="git checkout -b"
alias pull="git pull"
alias push="git push"
alias stat="git status"
alias gdiff="git diff HEAD"
alias vdiff="git difftool HEAD"
alias reset="git reset --soft HEAD~1"
alias ls='ls --color=auto -h'
alias ll="ls -lah"
alias lsd="ls -l | grep '^d'"
alias log="git log --pretty=format:'%C(yellow)%h%Creset %s %Cblue<%an>%Creset %Cgreen(%ar)%Creset' --abbrev-commit"
alias loggraph="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias g="lazygit"
alias mkdir='mkdir -p'
alias rm='rm -i'
alias zshconfig="v ~/.zshrc"
alias sourcezsh="source ~/.zshrc"
alias dcr="docker-compose run --rm"
alias awsume=". awsume"
alias k="kubectl"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcdro="docker-compose down --remove-orphans"
alias dcub="docker-compose up --build"
alias dcud='docker-compose -f docker-compose.debug.yml up'
alias migrate="docker-compose run --rm app python manage.py migrate"
alias makemigs="docker-compose run --rm app python manage.py makemigrations"
alias splus="dcr app python manage.py shell_plus"
alias ghcp="gh copilot suggest"
alias ghpr="EDITOR=vim gh pr create"
alias v=nvim
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cl="clear"
alias l="eza --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias fzfv="fzf | xargs nvim"
alias vz='NVIM_APPNAME=nvim-raw nvim'
alias gh="EDITOR=nvim gh"
alias d="lazydocker"
alias snowsql="/Applications/SnowSQL.app/Contents/MacOS/snowsql"
alias ksnv='NVIM_APPNAME="nvim-kickstart" nvim'
alias lvim='NVIM_APPNAME="lvim" nvim'
alias astart='nvm use 16 && npm start'
alias crunserver='dcr --service-ports app python manage.py runserver 0.0.0.0:8000'
alias cstatic='docker-compose up static'
alias cat='bat --paging=never'

# Git Aliases for GitHub Flow
alias gec='git config --global -e'
alias gup='git pull --rebase --prune && git submodule update --init --recursive'
alias gcob='git checkout -b'
alias gcm='git add -A && git commit -m'
alias gsave='git add -A && git commit -m "SAVEPOINT"'
alias gwip='git add -u && git commit -m "WIP"'
alias gundo='git reset HEAD~1 --mixed'
alias gamend='git commit -a --amend'
alias gwipe='git add -A && git commit -qm "WIPE SAVEPOINT" && git reset HEAD~1 --hard'

function gdefault() {
  git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@"
}
alias gdefault="gdefault"

function gbclean() {
  local DEFAULT=$(gdefault)
  git branch --merged "${1:-$DEFAULT}" | grep -v " ${1:-$DEFAULT}$" | xargs git branch -d
}
alias gbclean="gbclean"

function gbdone() {
  local DEFAULT=$(gdefault)
  git checkout "${1:-$DEFAULT}" && gup && gbclean "${1:-$DEFAULT}"
}
alias gbdone="gbdone"

# Custom Functions
killport() {
  kill -9 $(lsof -ti :$1)
}

mkcd() { mkdir -p "$1" && cd "$1"; }

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# use fzf with args eg mv, cp, rm etc
function f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fkill - kill processes - list only the ones you can kill
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

# b - browse chrome bookmarks
b() {
     bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks

     jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

    jq -r "$jq_script" < "$bookmarks_path" \
        | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
        | fzf --ansi \
        | cut -d$'\t' -f2 \
        | xargs open
}

# PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$(pyenv root)/shims:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:$HOME"
export PATH="$HOME/workspace/tools/bin/:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/zig-versions/zig-0.14.0-dev:$PATH"
export PICO_SDK_PATH="$HOME/pico-sdk"
export PATH=$PATH:$(go env GOPATH)/bin

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3

if [ -f ~/.zshprivate ]; then
    source ~/.zshprivate
else
    print "404: ~/.zsh/zshalias not found."
fi
# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
