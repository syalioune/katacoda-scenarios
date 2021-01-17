#!/bin/bash

cd /opt/kafka/bin

./kafka-topics.sh --describe --topic my-topic --zookeeper localhost:2181 > result.txt

head -n 1 result.txt | awk '$1=$1' | grep "Topic: my-topic PartitionCount: 2 ReplicationFactor: 1 Configs:" && echo "done"