source $ZDOTDIR/aliases

fpath=($ZDOTDIR/ $fpath)

# Autocomplete
autoload -U compinit; compinit

# Completions
source "$ZDOTDIR/plugins/zsh-completions/zsh-completions.plugin.zsh"

# Prompt
fpath+=($ZDOTDIR/plugins/pure/)
source "$ZDOTDIR/plugins/pure/pure.zsh"

# Vi mode in zsh
bindkey -v
export KEYTIMEOUT=1

# Cursor mode
source "$ZDOTDIR/plugins/cursor_mode"

# Syntax highlighting
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
