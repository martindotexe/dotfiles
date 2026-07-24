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

# Zsh vi mode
source $HOME/.config/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

bindkey -v

bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word

function zvm_after_init() {
  zvm_bindkey viins '^P' up-line-or-search
  zvm_bindkey viins '^N' down-line-or-search
  zvm_bindkey vicmd '^P' up-line-or-search
  zvm_bindkey vicmd '^N' down-line-or-search
}

# 25ms for key sequences
KEYTIMEOUT=25

# Vi-mode
ZVM_VI_SURROUND_BINDKEY=s-prefix
ZVM_SYSTEM_CLIPBOARD_ENABLED=true

# History
HISTFILE=$ZDOTDIR/.zsh_history

SAVEHIST=10000
HISTSIZE=50000

# Improve history behavior
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate entries, keeping only the latest
setopt HIST_IGNORE_DUPS       # Prevent consecutive duplicate commands from being stored
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate commands to history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_SPACE      # Don't save commands that start with a space
setopt HIST_REDUCE_BLANKS     # Remove unnecessary whitespace from history entries
setopt SHARE_HISTORY          # Share history across multiple terminal sessions
setopt INC_APPEND_HISTORY     # Immediately append new commands to history file

# Prevent history file corruption (important for large history)
setopt EXTENDED_HISTORY  # Save timestamps for each command
setopt APPEND_HISTORY    # Append history instead of overwriting it
setopt HIST_NO_STORE     # Prevent 'history' command itself from being stored

# Options
setopt extendedglob globstarshort
setopt incappendhistory extendedhistory
setopt autocd autopushd
setopt rcexpandparam rcquotes
setopt cbases octalzeroes
