#!/usr/bin/env zsh

#Check if $EDITOR is set
if [[ -z $EDITOR ]]; then
	EDITOR=vi
fi

CHT_SH_LIST_CACHE_DIR=$XDG_CACHE_HOME/'chtsh'
CHT_SH_LIST_CACHE=$CHT_SH_LIST_CACHE_DIR/'cht_sh_cached_list'

#Cache the list on first run
if [[ ! -f $CHT_SH_LIST_CACHE ]]; then
	echo 'Caching cht.sh list...'
    mkdir -p $CHT_SH_LIST_CACHE_DIR
    curl -s cht.sh/:list | grep -v -E '^[^/\n]*/$' > $CHT_SH_LIST_CACHE
fi

if [[ -z $1 ]]; then
	#Select a cht.sh cheat from the list
	selected=`cat $CHT_SH_LIST_CACHE | fzf --reverse --height 75% --border -m --ansi --nth 2..,.. --prompt='CHEAT.SH> ' --preview='curl -s cht.sh/{}' --preview-window=right:80%`
	if [[ -z $selected ]]; then
		exit 0
	fi
	$EDITOR <(curl -s cht.sh/$selected\?T)

else
	$EDITOR <(curl -s cht.sh/$1\?T)
fi
