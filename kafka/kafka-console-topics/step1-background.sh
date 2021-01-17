#!/bin/bash

echo "Initiating Kafka deployment"

launch.sh | tee /opt/background.log

kubectl create ns kafka | tee /opt/background.log

kubectl apply -f kafka-deployment.yaml -n kafka | tee /opt/background.log

kubectl wait --for=condition=available --timeout=300s deployment/kafka -n kafka | tee /opt/background.log

kubectl port-forward -n kafka --address 0.0.0.0 deployment/kafka 9090:9090 2181:2181 &

wget "https://apache.mediamirrors.org/kafka/2.7.0/kafka_2.12-2.7.0.tgz" -O kafka_2.12-2.7.0.tgz | tee /opt/background.log

tar xvfz kafka_2.12-2.7.0.tgz | tee /opt/background.log

chmod +x ./kafka_2.12-2.7.0/bin/*.sh | tee /opt/background.log

mv kafka_2.12-2.7.0 /opt/kafka | tee /opt/background.log

echo "step-1 background" | tee /opt/background.log

/opt/kafka/bin/kafka-topics.sh --create --topic topic1 --partitions 1 --replication-factor 1 --zookeeper localhost:2181 
/opt/kafka/bin/kafka-topics.sh --create --topic topic2 --partitions 2 --replication-factor 1 --zookeeper localhost:2181
/opt/kafka/bin/kafka-topics.sh --create --topic topic3 --partitions 3 --replication-factor 1 --zookeeper localhost:2181
/opt/kafka/bin/kafka-topics.sh --create --topic topic4 --partitions 10 --replication-factor 1 --zookeeper localhost:2181
/opt/kafka/bin/kafka-topics.sh --create --topic topic5 --partitions 5 --replication-factor 1 --zookeeper localhost:2181

echo "done" | tee /opt/.backgroundfinished