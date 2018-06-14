#!/bin/sh

if [ ! -f /etc/rozofs/rozofs.conf ]; then
  touch /etc/rozofs/rozofs.conf
fi
if [ ! -f /etc/rozofs/exportd.conf ]; then
  echo 'layout=0;volumes=();exports=();' > /etc/rozofs/exportd.conf
fi

/bin/busybox syslogd
/usr/bin/exportd "$@"
EXIT_CODE=$?

if [ "$EXIT_CODE" -ne "0" ]; then
  cat /var/log/messages
  exit $EXIT_CODE
fi

PID=$(pgrep -fn "^/usr/bin/exportd")
if [ -n "$PID" ]; then
  for i in `seq 1 15`; do
    trap "kill -s $i $PID; wait \$!" $i
  done
  tail -n0 --pid=$PID -f /var/log/messages & wait $!
fi
