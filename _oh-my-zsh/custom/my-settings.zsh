echo "$(basename $0) is being sourced..."

# current directory
PATH="${PATH:+${PATH}:}."

alias ll="ls -la"

EDITOR="/usr/bin/vim"; export EDITOR

alias chrome-no-security="/opt/google/chrome/chrome --disable-web-security --user-data-dir=/tmp/test-profil-ohne-cors"
alias editext="vim ~/.oh-my-zsh/custom/my-settings.zsh"
alias sourcehh="source ~/.zshrc"


export FZF_DEFAULT_COMMAND="fd . $HOME"
alias info="info --vi-keys"


alias dockerbuild="docker pull emsforge.services.ems/emsconda-develop:latest && \
    docker run -it --rm \
    --volume=/etc/emsencrypt:/etc/emsencrypt \
    --volume=/home/deinname:/host \
    emsforge.services.ems/emsconda-develop:latest \
    bash -c 'conda update --all --yes ems-conda-tools; cd /host; bash'"

export XDG_CONFIG_HOME=$HOME/.config


# ZSH AUTOSUGGESTIONS OPTIONS
# make CTRL + SPACE accept current autosuggestion
bindkey '^ ' autosuggest-accept

echo "$(basename $0) end..."
