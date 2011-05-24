#!/usr/bin/env python3
"""
Creates symlinks in your home directory for each file in this repository
starting with an undersore (which will of course be replaced by a dot).

If a file with that name already exists, it will be moved to
``<filename>.orig``.

"""
import glob
import os
import os.path
import re
import time


home = os.path.expanduser('~')
for entry in glob.glob('_*'):
    source = os.path.join(os.getcwd(), entry)
    target = os.path.join(home, re.sub('^_', '.', entry))

    if os.path.exists(target):
        print('Backupping %s' % target)
        os.rename(target, '%s.%s' % (target, time.strftime('%Y%m%d_%H%M%S')))

    os.symlink(source, target)
