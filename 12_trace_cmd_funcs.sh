#!/bin/bash

TRACEFUNCS="-g scheduler_tick"

TRACECMD=./trace-cmd

if [ "$1" = "start" ]; then
        echo 5120 > /sys/kernel/debug/tracing/buffer_size_kb
        cat /sys/kernel/debug/tracing/buffer_size_kb
        $TRACECMD reset
        $TRACECMD start -p function_graph $TRACEFUNCS
elif [ "$1" = "stop" ]; then
        # after run the case, stop trace
        $TRACECMD stop
        $TRACECMD extract -o ./trace.dat
fi
