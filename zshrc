# git clone https://github.com/romkatv/powerlevel10k.git 
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
#autoload -U promptinit && promptinit
autoload -Uz compinit && compinit
# For Solarized
export TERM="xterm-256color"

plugins=(aws dirhistory dnf docker fzf git git-extras gnu-utils golang history jsontools kubectl screen sudo systemadmin terraform zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-interactive-cd)

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# date in history
HIST_STAMPS="mm/dd/yyyy"

source $ZSH/oh-my-zsh.sh

source <(msk-bin shellwrapper zsh)
source <(msk-bin completion zsh)

# Customize to your needs...
export GOPATH=$HOME/Projects/go
export GOBIN=$GOPATH/bin
export GO111MODULE=on
export GOPROXY=https://proxy.golang.org
export PATH=$HOME/bin:$HOME/.local/bin:$GOBIN:${HOME}/.krew/bin:~/.porter:$PATH

eval "$(starship init zsh)"

if [ $TERMINIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Example aliases
alias cat="bat -pp"
alias http="ht"
alias download="http -b --download"
alias grep="rg"
alias httpb="http -b"
alias kns="msk ns"
alias kctx="msk ctx"
alias ls="exa"
alias top="btm -b"
alias kubectl="kubecolor"

compdef kubecolor=kubectl

setopt nobeep
