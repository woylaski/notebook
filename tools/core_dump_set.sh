#!/bin/bash

ulimit -c unlimited

echo "/root/core-%e-%p-%t" > /proc/sys/kernel/core_pattern
