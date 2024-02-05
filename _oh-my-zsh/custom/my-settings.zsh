echo "my-settings.zsh is being sourced..."

# Ruby Tools Path
export PATH="/home/jan-magnus/projects/ruby-tools":$PATH

# Rust Cargo Bin
export PATH="/home/jan-magnus/.cargo/bin":$PATH

# bat-extras
export PATH="/home/jan-magnus/.local/bin/bat-extras":$PATH

# Current Working Dir as last resort to path
export PATH=$PATH:.

alias ll="ls -la"
alias gitfiles="git status --short | grep -v '^ *D' | grep -v '^R[^M]' | cut -c4- | sed 's/.* -> //'"

EDITOR="/usr/bin/vim"; export EDITOR

alias chrome-no-security="/opt/google/chrome/chrome --disable-web-security --user-data-dir=/tmp/test-profil-ohne-cors"
alias editext="vim ~/.oh-my-zsh/custom/my-settings.zsh"
alias sourcehh="source ~/.zshrc"


export FZF_DEFAULT_COMMAND="fd . $HOME"
alias ls="exa"
alias l="ll"
alias info="info --vi-keys"

# Man Pages
function manswitch() { man -P "less -p \"^ +$2\"" $1; }

# MANPATH
export MANPATH="$(manpath -g):/home/jan-magnus/.cargo/"


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

