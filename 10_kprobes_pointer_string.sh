#!/bin/sh

DEBUGFS=/sys/kernel/debug

if [ $1 = 'start' ]; then
	echo 'p:myprobe enqueue_task_fair tsk_name=+1520(%x1):string' > $DEBUGFS/tracing/kprobe_events
	echo 1 > $DEBUGFS/tracing/events/kprobes/myprobe/enable
	echo 1 > $DEBUGFS/tracing/tracing_on
elif [ $1 = 'stop' ]; then
	echo 0 > $DEBUGFS/tracing/tracing_on
	echo 0 > $DEBUGFS/tracing/events/kprobes/myprobe/enable
	echo '-:myprobe enqueue_task_fair tsk_name=+1520(%x1):string' >> $DEBUGFS/tracing/kprobe_events
	exit
fi
