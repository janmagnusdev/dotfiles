if [[ ! `uname` == "Darwin"* ]]; then
  return
fi

echo "$(basename $0) is being sourced..."

# Cargo Bins
PATH="${PATH:+${PATH}:}/Users/jan-magnus/.cargo/bin"

if command -v viman &> /dev/null
then
  alias man="viman"
fi

# pnpm
export PNPM_HOME="/Users/jan-magnus/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

echo "$(basename $0) end..."
