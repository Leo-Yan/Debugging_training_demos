#!/bin/sh

DEBUGFS=/sys/kernel/debug

echo 0 > $DEBUGFS/tracing/tracing_on
echo 0 > $DEBUGFS/tracing/events/enable

echo > $DEBUGFS/tracing/set_event_pid

echo > $DEBUGFS/tracing/set_ftrace_pid
echo > $DEBUGFS/tracing/set_ftrace_filter
echo > $DEBUGFS/tracing/set_ftrace_notrace

echo > $DEBUGFS/tracing/set_graph_function
echo > $DEBUGFS/tracing/set_graph_notrace

echo nop > $DEBUGFS/tracing/current_tracer

echo > $DEBUGFS/tracing/kprobe_events

cat $DEBUGFS/tracing/trace_pipe > /dev/null
