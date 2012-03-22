#!/usr/bin/env python3
import os
import os.path
import subprocess

git_bundles = [
    'https://github.com/MarcWeber/vim-addon-mw-utils.git mw-utils',
    'https://github.com/tomtom/tlib_vim.git tlib',
    'https://github.com/garbas/vim-snipmate.git snipmate',
    'https://github.com/ervandew/supertab.git supertab',
    'https://github.com/tpope/vim-surround.git surround',
    'https://github.com/wincent/Command-T.git command-t',
    'https://github.com/mitechie/pyflakes-pathogen.git pyflakes',
    'https://github.com/fs111/pydoc.vim.git pydoc',
    'https://github.com/vim-scripts/pep8.git pep8',
    'https://github.com/alfredodeza/pytest.vim.git py.test',
    'https://github.com/vim-scripts/TaskList.vim.git tasklist',
    'https://github.com/vim-scripts/The-NERD-tree.git nerdtree',
    'https://github.com/sontek/rope-vim.git ropevim',
    'https://github.com/vim-scripts/SearchComplete.git searchcomplete',
]

vim_org_scripts = [
    'rename', 1928, 'plugin'
    # 'name', 123, 'plugin',
    # 'name', 456, 'syntax',
]

BUNDLE_DIR = '_vim/bundle'


def clone():
    os.makedirs(BUNDLE_DIR)
    for repo in git_bundles:
        subprocess.call(['git', 'clone'] + repo.split(' '), cwd=BUNDLE_DIR)

    # Build comand-t
    subprocess.call(['rake', 'make'], cwd=os.path.join(BUNDLE_DIR,
            'command-t'))


def update():
    for repo in git_bundles:
        local_dir = repo.split(' ')[1]
        print('- Updading %s ...' % local_dir)
        subprocess.call(['git', 'pull'],
                cwd=os.path.join(BUNDLE_DIR, local_dir))


if __name__ == '__main__':
    import sys
    if len(sys.argv) == 2 and sys.argv[1] == 'clone':
        clone()
    else:
        update()
