#!/bin/sh
DEBUGFS=/sys/kernel/debug

if [ $1 = 'start' ]; then
	echo 'hist:keys=call_site.sym:values=bytes_req:sort=bytes_req.descending' > $DEBUGFS/tracing/events/kmem/kmalloc/trigger
	echo 1 > $DEBUGFS/tracing/events/kmem/kmalloc/enable
	./main
elif [ $1 = 'stop' ]; then
	cat $DEBUGFS/tracing/events/kmem/kmalloc/hist > /tmp/event_trigger_callsite.log
	echo '!hist:keys=call_site.sym:values=bytes_req:sort=bytes_req.descending' > $DEBUGFS/tracing/events/kmem/kmalloc/trigger
	echo 0 > $DEBUGFS/tracing/events/kmem/kmalloc/enable
	exit
fi
