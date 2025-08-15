if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(zsh-autosuggestions zsh-syntax-highlighting git tmux cp z copyfile)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.local/bin"

export PATH="$PATH:$HOME/.nvim/bin"

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL=C
export TERM="xterm-256color"

. $HOME/.aliases
. $HOME/.funcs

