#!/bin/sh

DEBUGFS=/sys/kernel/debug

if [ $1 = 'start' ]; then
	echo function > $DEBUGFS/tracing/current_tracer

	echo block* > $DEBUGFS/tracing/set_ftrace_filter
	echo 1 > $DEBUGFS/tracing/tracing_on

elif [ $1 = 'stop' ]; then

	echo 0 > $DEBUGFS/tracing/tracing_on
	echo > $DEBUGFS/tracing/set_ftrace_filter

	cat $DEBUGFS/tracing/trace > /tmp/function.log
	cat $DEBUGFS/tracing/trace_pipe > /dev/null

	echo nop > $DEBUGFS/tracing/current_tracer
	exit
fi
