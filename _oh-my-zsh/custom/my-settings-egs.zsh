if [[ ! `hostname` == *"egs-dev-008."* ]]; then
  return
fi

echo "$(basename $0) is being sourced..."

# Allow activation and usage emsconda env
export EMSCONDA_DIR="${HOME}/emsconda"
source "${EMSCONDA_DIR}/etc/profile.d/ems_rc.sh"
# Include default aliases like dev, ca, da (Optional)
source "${EMSCONDA_DIR}/etc/profile.d/ems_alias.sh"

echo "$(basename $0) end..."