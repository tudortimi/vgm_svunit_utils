#!/bin/env python2.7

import os

command = ['runSVUnit']
command.append('-s ius')
command.append('--uvm')

os.system(' '.join(command))
