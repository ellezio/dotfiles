#!/usr/bin/env bash

killall -q .polybar-wrappe

while pgrep -x .polybar-wrappe >/dev/null; do sleep 1; done

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar &
	done
else
	polybar &
fi

# vim:ts=4:sw=4:noet
