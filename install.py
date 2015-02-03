#!/usr/bin/env python3
"""
Creates symlinks in your home directory for each file in this repository
starting with an undersore (which will of course be replaced by a dot).

If a file with that name already exists, it will be moved to
``<filename>.orig``.

"""
import glob
import os
import re
import time


home = os.path.expanduser('~')
extra_links = {}
if os.path.isdir('./_private'):
    extra_links['_private/ssh/config' = '.ssh/config',

entries = glob.glob('_*') + list(extra_links)
for entry in entries:
    source = os.path.join(os.getcwd(), entry)
    target = extra_links[entry] if entry in extra_links else \
             re.sub('^_', '.', entry)
    target = os.path.join(home, target)

    if os.path.exists(target):
        print('Backing up %s' % target)
        os.rename(target, '%s.%s' % (target, time.strftime('%Y%m%d_%H%M%S')))

    os.symlink(source, target)
