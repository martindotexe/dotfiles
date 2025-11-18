ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Prompt
zinit ice id-as'pure' compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'; zinit light sindresorhus/pure

# Vi mode - load first without wait
zinit depth'1' lucid light-mode for \
	id-as'zsh-vi-mode' \
		@jeffreytse/zsh-vi-mode

# fzf - load after with wait
zinit as'program' depth'1' wait'0a' lucid light-mode for \
	id-as'fzf' \
		from'gh-r' \
		atclone'./fzf --zsh > init.zsh && zcompile init.zsh' \
		atpull'%atclone' \
		src'init.zsh' \
		@junegunn/fzf \

zinit as"command" light-mode for \
	id-as"bat" \
		from"gh-r" \
		mv"bat* -> bat" \
		pick"bat/bat" \
		@sharkdp/bat

zinit depth'1' wait'0b' lucid light-mode for \
	id-as'fzf-tab' \
    	@Aloxaf/fzf-tab \
	id-as'zsh-you-should-use' \
    	@MichaelAquilina/zsh-you-should-use

# Syntax highlighting and completions
zinit depth'1' wait'0c' lucid light-mode for \
	id-as'fast-syntax-highlighting' \
		@zdharma-continuum/fast-syntax-highlighting \
	id-as'zsh-autosuggestions' \
		atload'!_zsh_autosuggest_start' \
		@zsh-users/zsh-autosuggestions

zinit depth'1' wait'0d' lucid light-mode for \
  id-as'zsh-completions' \
    blockf \
    atpull'zinit creinstall -q .' \
    atinit'zicompinit; zicdreplay' \
    @zsh-users/zsh-completions

# Prefrences
ZVM_VI_SURROUND_BINDKEY='s-prefix'

YSU_IGNORED_ALIASES=(
	'ls'
	'l'
	'll'
	'lls'
	'la'
	'lc'
)

HISTSIZE=10000
HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle :prompt:pure:git:stash show yes

# Key bindings
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# Aliases
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'

alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -lahF'
alias lls='ls -lahFtr'
alias la='ls -A'
alias lc='ls -CF'

# bun completions
[ -s "/home/martin/.bun/_bun" ] && source "/home/martin/.bun/_bun"
