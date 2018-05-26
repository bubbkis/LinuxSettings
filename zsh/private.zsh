source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export TERM=xterm-256color
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export LANG=ja_JP.UTF-8
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    # tmux�Ή�
    for D in `\ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
fi
eval "$(pyenv virtualenv-init -)"
eval "$(pipenv --completion)"

setopt print_eight_bit
source  ~/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3


### latex compile functions ###
texc (){
    files=$(echo $@ | sed -e 's/\.tex//g');
    for file in $files; do
        platex "$file".tex;
        echo "--------------------------------------\n"
        dvipdfmx "$file".dvi > /dev/null;
        ls $file* | grep -v -e '.tex' -e '.pdf' | xargs rm;
    done

    echo "open viewer? [y/n]"
    read resp
    
    if [ $(echo $resp | grep '[y|Y]' | wc -l) -ge 1 ]; then
	    for file in $files; do
	        command open ${file}.pdf;
	    done
    fi
    echo "-------- compile END --------"
}

alias hilite='/usr/bin/src-hilite-lesspipe.sh'
alias less='less -R'
