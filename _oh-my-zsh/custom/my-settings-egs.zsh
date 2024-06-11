if [[ `hostname` != *"egs-dev-008."* ]]; then
  return
fi

echo "$(basename $0) is being sourced..."

emsconda-init() {
  # Allow activation and usage emsconda env
  export EMSCONDA_DIR="${HOME}/emsconda"
  source "${EMSCONDA_DIR}/etc/profile.d/ems_rc.sh"
  # Include default aliases like dev, ca, da (Optional)
  source "${EMSCONDA_DIR}/etc/profile.d/ems_alias.sh"
}

miniforge-init() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/home/jan-magnus/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/jan-magnus/miniforge3/etc/profile.d/conda.sh" ]; then
          . "/home/jan-magnus/miniforge3/etc/profile.d/conda.sh"
      else
          export PATH="/home/jan-magnus/miniforge3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}

alias emsconda-dockerbuild="docker pull emsforge.services.ems/emsconda-develop:latest && \
    docker run -it --rm \
    --volume=/etc/emsencrypt:/etc/emsencrypt \
    --volume=/home/deinname:/host \
    emsforge.services.ems/emsconda-develop:latest \
    bash -c 'conda update --all --yes ems-conda-tools; cd /host; bash'"

echo "$(basename $0) end..."