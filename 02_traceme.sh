#!/bin/sh
DEBUGFS=/sys/kernel/debug

echo $$ > $DEBUGFS/tracing/set_ftrace_pid
echo $$ > $DEBUGFS/tracing/set_event_pid
echo function > $DEBUGFS/tracing/current_tracer
echo 1 > $DEBUGFS/tracing/tracing_on

exec $*

echo 0 > $DEBUGFS/tracing/tracing_on
echo > $DEBUGFS/tracing/set_ftrace_pid
echo > $DEBUGFS/tracing/set_event_pid
echo nop > $DEBUGFS/tracing/current_tracer
