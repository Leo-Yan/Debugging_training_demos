#!/bin/sh

DEBUGFS=/sys/kernel/debug

if [ $1 = 'start' ]; then
	echo 'r:myproberet do_sys_open $retval' > $DEBUGFS/tracing/kprobe_events
	echo 1 > $DEBUGFS/tracing/events/kprobes/myproberet/enable
	echo 1 > $DEBUGFS/tracing/tracing_on
elif [ $1 = 'stop' ]; then
	echo 0 > $DEBUGFS/tracing/tracing_on
	echo 0 > $DEBUGFS/tracing/events/kprobes/myproberet/enable
	echo '-:myproberet do_sys_open $retval' >> $DEBUGFS/tracing/kprobe_events
	exit
fi
