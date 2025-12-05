# Pure theme (sindresorhus/pure)
fpath+=($HOME/.config/zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# Zsh completions
fpath=($HOME/.config/zsh/zsh-completions/src $fpath)

# Fzf-tab
autoload -U compinit; compinit
source $HOME/.config/zsh/fzf-tab/fzf-tab.plugin.zsh

# Fsh (zdharma-continuum/fast-syntax-highlighting)
source $HOME/.config/zsh/fsh/fast-syntax-highlighting.plugin.zsh

# Zsh-autosuggestions (zsh-users/zsh-autosuggestions)
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word

bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Emacs mode
# bindkey -e

# Lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

HISTSIZE=10000
HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase

