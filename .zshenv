export DOTFILES="$HOME/.dotfiles"
export WORKSPACE="$HOME/workspace"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Compinit
export skip_global_compinit=1

# Scripts
export PATH="$HOME/.dotfiles/scripts:$PATH"

# Go
export PATH=$PATH:/usr/local/go/bin

# Pico8
export PATH=$PATH:/usr/local/pico-8

# NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=$PATH:/opt/homebrew/bin
fi
