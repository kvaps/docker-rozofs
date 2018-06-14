#!/bin/sh

# restore configs
if [ ! -f /etc/rozofs/rozofs.conf ]; then
  touch /etc/rozofs/rozofs.conf
fi
if [ ! -f /etc/rozofs/exportd.conf ]; then
  echo 'layout=0;volumes=();exports=();' > /etc/rozofs/export.conf
fi

# start logging
/bin/busybox syslogd
tail -f /var/log/messages &

# start daemon
/usr/bin/exportd "$@" || exit $?

# wait for process
PID=$(pgrep -fn "^/usr/bin/exportd")
if [ -n "$PID" ]; then
  for i in `seq 1 15`; do
    trap "kill -s $i $PID; wait \$!" $i
  done
  tail --pid=$PID -f /dev/null & wait $!
fi
