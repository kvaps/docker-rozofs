#!/bin/sh

# restore configs
if [ ! -f /etc/rozofs/rozofs.conf ]; then
  touch /etc/rozofs/rozofs.conf
fi
if [ ! -f /etc/rozofs/storaged.conf ]; then
  echo 'listen=({addr="*";port=41001;});storages=();' > /etc/rozofs/storage.conf
fi

# start logging
/bin/busybox syslogd
tail -F /var/log/messages 2>/dev/null &

# start daemon
/usr/bin/storaged "$@" || exit $?

# wait for process
PID=$(pgrep -fn "^/usr/bin/storaged")
if [ -n "$PID" ]; then
  for i in `seq 1 15`; do
    trap "kill -s $i $PID; wait \$!" $i
  done
  tail -n0 --pid=$PID -f /var/log/messages & wait $!
fi
