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
fi
unset -f deno_completions

echo "$(basename $0) end..."