#!/bin/sh

DEBUGFS=/sys/kernel/debug

if [ $1 = 'start' ]; then
	echo function > $DEBUGFS/tracing/current_tracer
	echo 'do_bad_area.part.1:traceoff' > $DEBUGFS/tracing/set_ftrace_filter
	echo 1 > $DEBUGFS/tracing/tracing_on
	./segfault

elif [ $1 = 'stop' ]; then

	#echo 0 > $DEBUGFS/tracing/tracing_on
	echo '!do_bad_area.part.1:traceoff' > $DEBUGFS/tracing/set_ftrace_filter
	cat $DEBUGFS/tracing/trace > /tmp/function_traceoff.log
	echo nop > $DEBUGFS/tracing/current_tracer
	exit
fi
