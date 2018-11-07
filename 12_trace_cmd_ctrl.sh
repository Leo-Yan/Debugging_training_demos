#!/bin/bash

TRACEPOINTS="-e cpu_idle -e cpu_frequency \
	     -e sched_switch -e irq_handler_entry \
	     -e softirq_raise -e sched_migrate_task "

TRACECMD=./trace-cmd

if [ "$1" = "record" ]; then
        $TRACECMD record -o ./trace.dat $TRACEPOINTS
elif [ "$1" = "start" ]; then
        echo 5120 > /sys/kernel/debug/tracing/buffer_size_kb
        cat /sys/kernel/debug/tracing/buffer_size_kb
        $TRACECMD reset
        $TRACECMD start $TRACEPOINTS
        echo TRACE_MARKER_START > /sys/kernel/debug/tracing/trace_marker
elif [ "$1" = "stop" ]; then
        # after run the case, stop trace
        echo TRACE_MARKER_STOP > /sys/kernel/debug/tracing/trace_marker
        $TRACECMD stop
        $TRACECMD extract -o ./trace.dat
fi
