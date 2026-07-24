typeset -U PATH path
export XMODIFIERS='@im=fcitx'

# Lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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

# PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.config/scripts"
  "$XDG_DATA_HOME/bob/nvim-bin"
  /usr/local/go/bin
  $path
)

case "$(uname -s)" in
  Darwin)
    # macOS
    path=(
      /Applications/1Password.app/Contents/MacOS
      /opt/homebrew/bin
      $path
    )
    ;;
  Linux)
    # Arch Linux
    path=(
      /opt/1Password
      $path
    )
    ;;
esac
