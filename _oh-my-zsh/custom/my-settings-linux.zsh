if [[ ! `uname` == "Linux"* ]]; then
  return
fi

echo "$(basename $0) is being sourced..."

# Emsconda Bins
PATH="${PATH:+${PATH}:}/home/jan-magnus/emsconda/bin"

# Ruby Tools Path
PATH="${PATH:+${PATH}:}/home/jan-magnus/programs/ruby-tools/"

# Rust Cargo Bin
PATH="${PATH:+${PATH}:}/home/jan-magnus/.cargo/bin"

# bat-extras
PATH="${PATH:+${PATH}:}/home/jan-magnus/.local/bin/bat-extras"

echo "Random tealdeer tip incoming!\n"
tldr --quiet $(tldr --quiet --list | shuf -n1)

echo "$(basename $0) end..."
