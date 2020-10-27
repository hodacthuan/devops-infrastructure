
## Kafka CLI
### Getting started
Download latest Kafka version here: https://www.apache.org/dyn/closer.cgi?path=/kafka/2.6.0/kafka_2.13-2.6.0.tgz

```bash
wget https://mirror.downloadvn.com/apache/kafka/2.6.0/kafka_2.13-2.6.0.tgz
tar -xzf kafka_2.13-2.6.0.tgz
cd kafka_2.13-2.6.0
```

Get topics list
```bash
./bin/kafka-topics.sh --zookeeper localhost:2181 --list
```
Console consumer
```bash
./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic local_sanitization_failure
```
## Roadmap
- Add Kafka, zookeeper docker images built using docker-compose
- Add Kafka manager deployment
## Acknowledge

- [Kafka Quickstart](https://kafka.apache.org/quickstart)
- [Kafka Manager](https://github.com/yahoo/CMAK)
- [Using Apache Kafka Command-line Tools](https://github.com/hodacthuan?tab=repositories)