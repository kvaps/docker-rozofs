#!/bin/sh

if [ ! -f /etc/rozofs/rozofs.conf ]; then
  touch /etc/rozofs/rozofs.conf
fi
if [ ! -f /etc/rozofs/storaged.conf ]; then
  echo 'listen=({addr="*";port=41001;});storages=();' > /etc/rozofs/storaged.conf
fi

/bin/busybox syslogd
/sbin/rpcbind
/usr/bin/storaged "$@"
EXIT_CODE=$?

if [ "$EXIT_CODE" -ne "0" ]; then
  cat /var/log/messages
  exit $EXIT_CODE
fi

PID=$(pgrep -fn "^/usr/bin/storaged $*&")
if [ -n "$PID" ]; then
  for i in `seq 1 15`; do
    trap "kill -s $i $PID; wait \$!" $i
  done
  tail -n0 --pid=$PID -f /var/log/messages & wait $!
fi
