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

echo "$(basename $0) end..."
