# Pure theme (sindresorhus/pure)
fpath+=($HOME/.config/zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# Zsh vi mode
source $HOME/.config/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

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

# Temporary nightly nvim
alias nvim-nightly="~/nvim-nightly/bin/nvim"

bindkey -v

bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word

function zvm_after_init() {
  zvm_bindkey viins '^P' up-line-or-search
  zvm_bindkey viins '^N' down-line-or-search
  zvm_bindkey vicmd '^P' up-line-or-search
  zvm_bindkey vicmd '^N' down-line-or-search
}

# 10ms for key sequences
KEYTIMEOUT=25

# Vi-mode
ZVM_VI_SURROUND_BINDKEY=s-prefix
ZVM_SYSTEM_CLIPBOARD_ENABLED=true

# History
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# Options
setopt extendedglob globstarshort
setopt incappendhistory extendedhistory
setopt autocd autopushd
setopt rcexpandparam rcquotes
setopt cbases octalzeroes

# Lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

