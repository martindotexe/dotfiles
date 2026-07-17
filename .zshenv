typeset -U PATH path
export XMODIFIERS='@im=fcitx'

# TERM color
export TERM=xterm-256color

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

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

# Bob
[[ -f "$HOME/.local/share/bob/env/env.sh" ]] && source "$HOME/.local/share/bob/env/env.sh"

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  export PATH=$PATH:/Applications/1Password.app/Contents/MacOS

  # Homebrew (Apple Silicon)
  if [[ -d /opt/homebrew/bin ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  # Homebrew (Intel)
  elif [[ -d /usr/local/Homebrew/bin ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  export PATH=$PATH:/opt/1Password
fi
