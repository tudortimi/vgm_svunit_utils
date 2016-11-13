#!/bin/env bash

./run.py > /dev/null

grep passes::FAILED run.log
grep fails::PASSED run.log
