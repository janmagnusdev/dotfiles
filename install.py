#!/usr/bin/env python3
"""
Creates symlinks in your home directory for each file in this repository
starting with an undersore (which will of course be replaced by a dot).

If a file with that name already exists, it will be moved to
``<filename>.orig``.

Also install a Vim plug-in manager.

"""
import glob
import os
import re
import subprocess
import time

import click


# TODO:
# - Move install tasks into functions that can be run separately
# - Actually install packages in PKGs
PKGS = {
    'brew': [
        'asciinema',
        'autojump',
        'bash',
        'bash-completion',
        'exiftool',
        'mercurial',
        'mobile-shell',
        'neovim',
        'pypy',
        'pypy3',
        'python',
        'python3',
        'python32',
        'python33',
        'python34',
        'python35',
        'rust',
    ],
    'brew-cask': [
        'vimr',
    ],
    'cargo': [
        'fd-find',
        'vcprompt',
    ],
    'dnf': [
        'autojump',
    ],
    'pipsi': [
        'fabric',
        'httpie',
        'salt',
    ],
}


@click.group(invoke_without_command=True)
@click.option('--backup/--no-backup', default=True, show_default=True,
              help='Backup files before overwriting them.')
@click.pass_context
def main(ctx, backup):
    """Run all sub-commands."""
    if ctx.invoked_subcommand is None:
        configs()
        vimplug(backup)


@main.command()
def configs():
    """Install/link config files."""
    home = os.path.expanduser('~')
    extra_links = {}
    if os.path.isdir('./_private'):
        extra_links['_private/ssh/config'] = '.ssh/config'

    entries = glob.glob('_*') + list(extra_links)
    for entry in entries:
        source = os.path.join(os.getcwd(), entry)
        target = extra_links[entry] if entry in extra_links else \
            re.sub('^_', '.', entry)
        target = os.path.join(home, target)

        if os.path.exists(target):
            print(f'Backing up {target}')
            os.rename(target, f'{target}.{time.strftime("%Y%m%d_%H%M%S")}')

        os.symlink(source, target)


@main.command()
@click.option('--backup/--no-backup', default=True, show_default=True,
              help='Backup files before overwriting them.')
def vimplug(backup):
    """Install the "vim-plug" plug-in manager."""
    # Install dein.vim
    url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    dest = '~/.vim/autoload/plug.vim'
    subprocess.run(f'curl -fLo {dest} --create-dirs {url}', shell=True)


if __name__ == '__main__':
    main()
