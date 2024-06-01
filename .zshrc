# Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set ZSH environment variable
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Source plugins
[ -d "/opt/homebrew/share/zsh-autosuggestions/" ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh || source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -d "/opt/homebrew/share/zsh-syntax-highlighting/highlighters" ] && export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters || export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
[ -d "/opt/homebrew/share/zsh-syntax-highlighting/" ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh || source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(git zsh-syntax-highlighting zsh-autosuggestions npm zsh-z)
source $ZSH/oh-my-zsh.sh

# Git Aliases
alias add="git add"
alias co="git checkout"
alias cob="git checkout -b"
alias pull="git pull"
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
alias ohmyzsh="nvim ~/.oh-my-zsh"
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
alias gh="EDITOR=vim gh"
alias dstopall='docker stop $* $(docker ps -q -f "status=running")'
alias v="nvim"

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

# Powerlevel10k, NVM, pyenv, Starship
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval $(thefuck --alias)

eval "$(atuin init zsh)"
source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3
alias vim=nvim

if [ -f ~/.zshprivate ]; then
    source ~/.zshprivate
else
    print "404: ~/.zsh/zshalias not found."
fi
