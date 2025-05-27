#!/bin/sh

#===========================================================================================
# Java Environment Setting
#===========================================================================================
error_exit ()
{
    echo "ERROR: $1 !!"
    exit 1
}

[ ! -e "$JAVA_HOME/bin/java" ] && JAVA_HOME=$HOME/jdk/java
[ ! -e "$JAVA_HOME/bin/java" ] && JAVA_HOME=/usr/java
[ ! -e "$JAVA_HOME/bin/java" ] && error_exit "Please set the JAVA_HOME variable in your environment, We need java(x64)!"

export JAVA_HOME
export JAVA="$JAVA_HOME/bin/java"
export BASE_DIR=$(dirname $0)/..
export CLASSPATH=${BASE_DIR}/lib/*:.:${BASE_DIR}/conf:${CLASSPATH}

echo $CLASSPATH
#===========================================================================================
# JVM Configuration
#===========================================================================================
JAVA_OPT="${JAVA_OPT} -server -Xms128m -Xmx128m "
JAVA_OPT="${JAVA_OPT} -cp ${CLASSPATH}"
JAVA_OPT="${JAVA_OPT} ${EXTRA_OPTS}"

$JAVA ${JAVA_OPT} $@


