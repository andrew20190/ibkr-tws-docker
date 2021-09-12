#!/bin/bash

echo WM start
fluxbox &

sleep 5

echo TWS startup
tws &

echo Pause
sleep 5 

if  test "${INIT_PAPER}" -gt 0 ; then
	echo INIT_PAPER mode
	xdotool key Tab Tab Tab Tab Tab Tab Tab Return Tab
fi

echo Transmit login
xdotool search --name '^Login$' windowactivate
xdotool type $TWS_USER
xdotool key Tab
xdotool type $TWS_PASS
xdotool key Return

sleep 30
echo Clicking accept if paper trading warning popped up
xdotool search --name Warning windowactivate
xdotool key Return

sleep infinity
