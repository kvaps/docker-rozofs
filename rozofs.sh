#!/bin/bash

start_daemons() {
  # start rozo agent
  /etc/init.d/rozofs-manager-agent start
  # start rozo export
  if [ "$(grep -c '\(volumes\|exports\) *= *( *) *;' /etc/rozofs/export.conf)" != "2" ]; then
    /etc/init.d/rozofs-exportd start
  fi
  # start rozo storage
  if [ "$(grep -c 'storages *= *( *) *;' /etc/rozofs/storage.conf)" != "1" ]; then
    /etc/init.d/rozofs-storaged start
  fi
}

stop_daemons() {
  /etc/init.d/rozofs-storaged stop
  /etc/init.d/rozofs-exportd stop
  /etc/init.d/rozofs-manager-agent stop
}

# start logging
/bin/busybox syslogd
tail -F /var/log/messages 2>/dev/null &

trap stop_daemons EXIT
start_daemons
wait $!
