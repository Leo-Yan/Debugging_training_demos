#!/bin/sh
DEBUGFS=/sys/kernel/debug

echo 1 > $DEBUGFS/tracing/events/enable
echo 1 > $DEBUGFS/tracing/tracing_on

./main

echo 0 > $DEBUGFS/tracing/tracing_on
echo 0 > $DEBUGFS/tracing/events/enable

exit
