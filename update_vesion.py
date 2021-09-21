#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import re

file_path = './BestInSlot/BestInSlot.toc'

if __name__ == "__main__":
    version = os.environ["ADDON_VERSION"]

    f = open(file_path, 'r')
    a = f.read()
    s = re.sub(r'.*## Version.*', '## Version: {}'.format(version), a, 1)
    
    f = open(file_path, 'w')
    f.write(s)

    f.close()
