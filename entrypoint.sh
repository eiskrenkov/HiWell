#!/bin/sh

echo Starting Server with $JVM_STARTING_MEMORY of memory and limit of $JVM_MEMORY_LIMIT

java -Xmx${JVM_MEMORY_LIMIT} -Xms${JVM_STARTING_MEMORY} -jar server.jar --universe universe --nogui
