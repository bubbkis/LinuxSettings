#source <(kompose completion zsh)
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc:$PATH
export PATH=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc:$PATH
export PATH=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/platform/google_appengine:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PIPENV_VENV_IN_PROJECT=true

fpath=(/usr/local/share/zsh-completions $fpath)

# Go
#export PATH=$HOME/go/bin:$PATH

# Rust
#export PATH=$HOME/.cargo/bin:$PATH
#export LD_LIBRARY_PATH=$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib
#export RLS_ROOT=$HOME/Develop/lang_server/rls

#alias hilite='/usr/bin/src-hilite-lesspipe.sh'
alias less='less -R'
alias lg='lazygit'
alias rm='trash'
alias lzd='lazydocker'
# ディレクトリ名でしぼってcd
alias pcd='cd "$(find . -type d | peco)"'
# ブランチ名で絞ってgit checkout
alias pgco='git branch --sort=-authordate | cut -b 3- | perl -pe '\''s#^remotes/origin/###'\'' | perl -nlE '\''say if !$c{$_}++'\'' | grep -v -- "->" | peco | xargs git checkout'
# ブランチ名で絞ってgit branch -d
alias pgbd='git br | peco | xargs git br -d'
# ブランチ名で絞ってgit rebase
alias pgrb='git br | peco | xargs git rebase'


if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

if [ -e /usr/local/share/zsh/site-functions ]; then
    fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    # tmux‘Î‰ž
    for D in `\ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
fi
eval "$(pyenv virtualenv-init -)"
eval "$(pipenv --completion)"
eval "$(goenv init -)"

setopt print_eight_bit
source  ~/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/bubbkis/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

alias swift='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift'


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

# Example
# chmod-r /path/to/dir d 755
# chmod-r /path/to/dir f 644
function chmod-r(){
  find $1 -type $2 -exec chmod $3 {} +
}