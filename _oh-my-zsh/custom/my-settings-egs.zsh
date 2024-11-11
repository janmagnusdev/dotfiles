if [[ `hostname` != *"egs-dev-008."* ]]; then
  return
fi

echo "$(basename $0) is being sourced..."

alias emsconda-dockerbuild="docker pull emsforge.services.ems/emsconda-develop:latest && \
    docker run -it --rm \
    --volume=/etc/emsencrypt:/etc/emsencrypt \
    --volume=/home/deinname:/host \
    emsforge.services.ems/emsconda-develop:latest \
    bash -c 'conda update --all --yes ems-conda-tools; cd /host; bash'"

# Go
PATH="${PATH:+${PATH}:}/home/jan-magnus/.local/bin/go/bin"

emsconda-init() {
  # Allow activation and usage emsconda env
  export EMSCONDA_DIR="${HOME}/emsconda"
  source "${EMSCONDA_DIR}/etc/profile.d/ems_rc.sh"
  # Include default aliases like dev, ca, da (Optional)
  source "${EMSCONDA_DIR}/etc/profile.d/ems_alias.sh"
}
emsconda-init

if [[ $(command -v "deno") ]]; then
  deno_completions
  export DENO_CERT="/home/jan-magnus/emsconda/ssl/cacert.pem"
  export DENO_TLS_CA_STORE="system"
fi
unset -f deno_completions

export MISE_SHELL=zsh
export __MISE_ORIG_PATH="$PATH"

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command mise
    return
  fi
  shift

  case "$command" in
  deactivate|s|shell)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command mise "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command mise "$command" "$@"
}

_mise_hook() {
  eval "$(mise hook-env -s zsh)";
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_mise_hook]+1}" ]]; then
  precmd_functions=( _mise_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_mise_hook]+1}" ]]; then
  chpwd_functions=( _mise_hook ${chpwd_functions[@]} )
fi

if [ -z "${_mise_cmd_not_found:-}" ]; then
    _mise_cmd_not_found=1
    [ -n "$(declare -f command_not_found_handler)" ] && eval "${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

    function command_not_found_handler() {
        if mise hook-not-found -s zsh -- "$1"; then
          _mise_hook
          "$@"
        elif [ -n "$(declare -f _command_not_found_handler)" ]; then
            _command_not_found_handler "$@"
        else
            echo "zsh: command not found: $1" >&2
            return 127
        fi
    }
fi


echo "$(basename $0) end..."