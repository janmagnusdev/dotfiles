#!/usr/bin/env python3
import os
import os.path
import subprocess


BUNDLE_DIR = '_vim/bundle'


def update():
    repo_types = {
        '.git': 'git pull',
        '.hg': 'hg pull -u',
        '.svn': 'svn up',
    }
    for entry in os.listdir(BUNDLE_DIR):
        for rtype, cmd in repo_types.items():
            path = os.path.join(BUNDLE_DIR, entry)
            if os.path.isdir(os.path.join(path, rtype)):
                print('- Updating %s ...' % entry)
                subprocess.call(cmd, cwd=path, shell=True)


if __name__ == '__main__':
    update()
