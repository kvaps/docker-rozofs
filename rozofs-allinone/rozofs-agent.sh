#!/bin/sh

# start logging
/bin/busybox syslogd
tail -F /var/log/messages 2>/dev/null &

# start daemon
/usr/bin/rozo agent stop
/usr/bin/rozo agent start || exit $?

# wait for process
PID=$(pgrep -fn "/usr/bin/rozo agent start")
if [ -n "$PID" ]; then
  for i in `seq 1 15`; do
    trap "kill -s $i $PID; wait \$!" $i
  done
  tail -n0 --pid=$PID -f /var/log/messages & wait $!
fi
