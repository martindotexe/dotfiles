# TERM color
export TERM=xterm-256color

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
export PATH=$PATH:"$HOME/.config/scripts"

# Go
export PATH=$PATH:/usr/local/go/bin

# Pico8
export PATH=$PATH:/usr/local/pico-8

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=$PATH:/opt/homebrew/bin
fi

# bun completions
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  [ -s "/Users/martin/.bun/_bun" ] && source "/Users/martin/.bun/_bun"
  . "$HOME/.config/local/share/../bin/env"
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="/Applications/1Password.app/Contents/MacOS/op-ssh-sign:$PATH"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  [ -s "/home/martin/.bun/_bun" ] && source "/home/martin/.bun/_bun"
  export PATH="/opt/1Password/op-ssh-sign:$PATH"
fi
