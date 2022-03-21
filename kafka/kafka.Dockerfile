FROM wurstmeister/kafka:latest
RUN sed -i -e 's/test-consumer-group/mdc-kafka-group/g' /opt/kafka/config/consumer.properties
RUN sed -i -e 's/localhost/mdc-kafka/g' /opt/kafka/config/consumer.properties
