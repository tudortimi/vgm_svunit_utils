#!/bin/env bash

./run.py -t tests/sva_macros_unit_test.sv > /dev/null

grep passes::FAILED ../build/svunit/run.log
grep fails::PASSED ../build/svunit/run.log
