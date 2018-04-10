#!/bin/bash
#
# node_exporter    NodeExporter daemon for Prometheus monitoring system
#
# chkconfig: 345 70 30
# description: NodeExporter provides an http endpoint for monitoring
#              system metrics
# processname: node_exporter
#
# deployment notes for RHEL 6:
# 1. copy node_exporter init script to /etc/init.d/
# 2. chmod 755 /etc/init.d/node_exporter
# 3. chkconfig --add node_exporter
# 4. chkconfig --list node_exporter  # shows init levels
#
# usage:
# service node_exporter start
# service node_exporter stop
# service node_exporter restart
# service node_exporter status
#
# logs:
LOGFILE=/var/opt/node_exporter.log

# Source function library.
. /etc/init.d/functions

RETVAL=0
prog="node_exporter"
exec=/opt/node_exporter/node_exporter
LOCKFILE=/var/lock/subsys/$prog

start() {
        echo -n "Starting $prog: "
        nohup $exec >>$LOGFILE 2>&1 &
        RETVAL=$?
        [ $RETVAL -eq 0 ] && echo_success && touch $LOCKFILE
        echo
        return $RETVAL
}

stop() {
        echo -n "Shutting down $prog: "
	killproc "$prog"
        RETVAL=$?
        [ $RETVAL -eq 0 ] && echo_success && rm -f $LOCKFILE
        echo
        return $RETVAL
}

status() {
        echo -n "Checking $prog status: "
	pid=`ps -ef | egrep "[/]opt/node_exporter/node_exporter" | awk '{print $2}'`
	if [ ! -z "$pid" ]; then
          echo_success
	else
	  echo_failure
	fi
	echo
        return $RETVAL
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: $prog {start|stop|status|restart}"
        exit 1
        ;;
esac
exit $RETVAL

