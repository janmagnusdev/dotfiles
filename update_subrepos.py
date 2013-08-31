#!/usr/bin/env python3
import re
import subprocess


repo = re.compile(r'\[(\w+)\](.*)')
commands = {
    'hg': 'hg pull -u',
    'git': 'git pull; git submodule update',
    'svn': 'svn up',
}

for line in open('.hgsub'):
    if not line.strip():
        continue

    local_dir, repo_def = line.split(' = ')
    repo_type, repo_url = repo.match(repo_def).groups()

    print('- Updating %s ...' % local_dir)
    subprocess.call(commands[repo_type], cwd=local_dir, shell=True)
