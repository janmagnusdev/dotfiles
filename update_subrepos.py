#!/usr/bin/env python3
import os
import re
import subprocess


repo = re.compile(r'\[(\w+)\](.*)')
commands = {
    'hg': 'hg pull -u',
    'git': 'git checkout master; git pull; git submodule update',
}

for line in open('.hgsub'):
    if not line.strip():
        continue

    local_dir, repo_def = line.split(' = ')
    repo_type, repo_url = repo.match(repo_def).groups()

    if not os.path.isdir(local_dir):
        local_dir = os.path.dirname(local_dir.rstrip('/'))
        print(' - Cloning %s to %s ...' % (repo_url, local_dir))
        subprocess.call([repo_type, 'clone', repo_url], cwd=local_dir)
    else:
        print('- Updating %s ...' % local_dir)
        subprocess.call(commands[repo_type], cwd=local_dir, shell=True)

if os.path.isdir('./_private'):
    print('- Updating _private ...')
    subprocess.call('hg pull -u', cwd='./_private', shell=True)
