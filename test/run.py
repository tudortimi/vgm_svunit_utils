#!/bin/env python2.7

import argparse
import os

parser = argparse.ArgumentParser(description="Run unit tests")
parser.add_argument("-g", "--gui", help="start in GUI mode",
                    action="store_true")
parser.add_argument("-t", "--test", help="run only selected test(s)",
                    action="append")
parser.add_argument("--uvm-version", help="run with selected UVM version (only supported for ius and xcelium",
                    choices=['1.1d', '1.2'])
args = parser.parse_args()

command = ['runSVUnit']

if args.gui:
    command.append('-c -linedebug')
    command.append('-r -gui')
    
if args.uvm_version:
    command.append('-r "-uvmhome CDNS-{version}"'.format(version=args.uvm_version))

if args.test:
    for test in args.test:
        command.append('-t ' + test)

os.system(' '.join(command))
