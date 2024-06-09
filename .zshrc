if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#   eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
# fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

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
alias zshconfig="nvim ~/.zshrc"
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
# Custom Functions
killport() {
  kill -9 $(lsof -ti :$1)
}

mkcd() { mkdir -p "$1" && cd "$1"; }

# PATH
export PATH=$(pyenv root)/shims:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:$HOME"
export PATH="$HOME/workspace/tools/bin/:$PATH"
export PATH="$HOME/.local/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval $(thefuck --alias)
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

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
