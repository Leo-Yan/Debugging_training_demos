#!/bin/sh

DEBUGFS=/sys/kernel/debug

if [ $1 = 'start' ]; then
	echo 'traceoff if comm ~ "main"' > $DEBUGFS/tracing/events/sched/sched_process_exit/trigger
	echo 1 > $DEBUGFS/tracing/events/sched/enable
	./02_traceme.sh ./main
elif [ $1 = 'stop' ]; then
	echo 0 > $DEBUGFS/tracing/events/sched/enable
	echo '!traceoff if comm ~ "main"' > $DEBUGFS/tracing/events/sched/sched_process_exit/trigger
	cat $DEBUGFS/tracing/trace > /tmp/event_trigger_traceoff.log

	echo 0 > $DEBUGFS/tracing/tracing_on
	echo '' > $DEBUGFS/tracing/set_event_pid
	cat $DEBUGFS/tracing/trace_pipe > /dev/null
	exit
fi
