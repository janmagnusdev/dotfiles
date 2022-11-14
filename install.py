#!/usr/bin/env python3
"""
Create symlinks in your home directory for each file in this repository
starting with an undersore (which will be replaced by a dot).

If a destination file already exists, create a backup first.

"""
import os
import pathlib
import re
import time


HOME = pathlib.Path.home()
HERE = pathlib.Path(__file__).parent.resolve()


def main():
    """Install/link config files."""
    HOME.joinpath(".config").mkdir(exist_ok=True)
    HOME.joinpath(".local", "bin").mkdir(parents=True, exist_ok=True)
    HOME.joinpath(".ssh").mkdir(mode=0o700, exist_ok=True)

    links = []

    for src in HERE.glob("_*"):
        dest = HOME / re.sub("^_", ".", str(src.relative_to(HERE)))
        links.append((src, dest))

    extra_links = {
        "_vim": ".config/nvim",
        "darkmode.sh": ".local/bin/dm",
        "iterm2_dark_mode_toggle.py": (
            "Library/Application Support/iTerm2/Scripts/AutoLaunch/"
            "iterm2_dark_mode_toggle.py"
        ),
    }
    if HERE.joinpath("_private").is_dir():
        extra_links["_private/ssh/config"] = ".ssh/config"
    for src, dest in extra_links.items():
        links.append((HERE / src, HOME / dest))

    bak_suffix = time.strftime("%Y%m%d%H%M%S")

    for src, dest in links:
        assert src.exists(), src
        if not dest.parent.is_dir():
            print(f"WARNING: Skipping link with missing parent directory: {dest}")
            continue

        if dest.exists():
            if dest.is_symlink() and dest.resolve() == src:
                continue

            bak = dest.with_name(f"{dest.name}.{bak_suffix}")
            print(f"Backing up {dest} -> {bak}")
            dest.rename(bak)
        if dest.is_symlink() and not dest.exists():
            dest.unlink()  # Remove broken symlinks

        print(f"Linking {src} -> {dest}")
        os.symlink(src, dest)

    for f in HOME.joinpath(".ssh").iterdir():
        f.chmod(0o600)


if __name__ == "__main__":
    main()
