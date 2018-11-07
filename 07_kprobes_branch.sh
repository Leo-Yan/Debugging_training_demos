#!/bin/sh

DEBUGFS=/sys/kernel/debug

if [ $1 = 'start' ]; then
	echo 'p:myprobe 0xffff00000812210c' > $DEBUGFS/tracing/kprobe_events
	echo 1 > $DEBUGFS/tracing/events/kprobes/myprobe/enable
	echo 1 > $DEBUGFS/tracing/tracing_on
elif [ $1 = 'stop' ]; then
	echo 0 > $DEBUGFS/tracing/tracing_on
	echo 0 > $DEBUGFS/tracing/events/kprobes/myprobe/enable
	echo '-:myprobe 0xffff00000812210c' >> $DEBUGFS/tracing/kprobe_events
	exit
fi
