#!/bin/env bash

./run.py -t sva_macros_unit_test.sv > /dev/null

grep passes::FAILED run.log
grep fails::PASSED run.log
