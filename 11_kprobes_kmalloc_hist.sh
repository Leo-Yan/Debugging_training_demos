#!/bin/sh

DEBUGFS=/sys/kernel/debug

if [ $1 = 'start' ]; then
	echo 'p:myprobe __kmalloc size=%x0:u32' > $DEBUGFS/tracing/kprobe_events
	echo 'hist:keys=stacktrace:values=size:sort=size.descending' > $DEBUGFS/tracing/events/kprobes/myprobe/trigger
	echo 1 > $DEBUGFS/tracing/events/kprobes/myprobe/enable
	echo 1 > $DEBUGFS/tracing/tracing_on
elif [ $1 = 'stop' ]; then
	cat $DEBUGFS/tracing/events/kprobes/myprobe/hist > /tmp/kprobes_hist.log
	echo 0 > $DEBUGFS/tracing/events/kprobes/myprobe/enable
	echo '!hist:keys=stacktrace:values=size:sort=size.descending' > $DEBUGFS/tracing/events/kprobes/myprobe/trigger
	echo '-:myprobe __kmalloc size=%x0:u32' >> $DEBUGFS/tracing/kprobe_events
	echo 0 > $DEBUGFS/tracing/tracing_on
	exit
fi
