#!/bin/sh
tomcat_home=/opt/tomcat7
conf_home=/opt/application/conf
tingyun=$tomcat_home/tingyun/tingyun-agent-java.jar
export CATALINA_PID=/opt/tomcat7/run/tomcat.pid
JVM_MEMORY="-Xms1g -Xmx1g -Xmn256m -XX:PermSize=128m -XX:MaxPermSize=128m -Xss256k"
if [ -n "$jvm_memory" ]; then
    JVM_MEMORY="$jvm_memory"
fi
if [ -f $tingyun ]; then
    export tingyunagent="-javaagent:$tingyun"
fi
export JAVA_OPTS=" -server \
$JVM_MEMORY \
-XX:SurvivorRatio=8 -XX:CMSInitiatingOccupancyFraction=70 \
-XX:+UseConcMarkSweepGC  -XX:+CMSParallelRemarkEnabled -XX:+UseParNewGC -XX:+UseCMSCompactAtFullCollection -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly \
-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$root/var/log \
-Dcom.sun.management.jmxremote -Djava.rmi.server.hostname=127.0.0.1 -Dcom.sun.management.jmxremote.port=6123 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false \
$tingyunagent
"
$tomcat_home/bin/catalina.sh start
WAIT_TIME=20
echo "wait for $WAIT_TIME seconds to check wether the process $pid is running"
sleep $WAIT_TIME
if [ ! -f $CATALINA_PID ]; then
        echo "no pid file for this application found, expect $CATALINA_PID"
        exit 1
fi
pid=`cat $CATALINA_PID`
if [ ! -n "$pid" ]; then
        echo "no pid for this application found"
        exit 1
fi
echo "get pid $pid"
if test $( ps ax | awk '{ print $1 }' | grep -e "^$pid$" |wc -l ) -eq 0
then
        echo "the process $pid is not running, please check log"
        exit 1
fi
