FROM wurstmeister/kafka:latest
RUN sed -i -e 's/test-consumer-group/mdc-kafka-group/g' /opt/kafka/config/consumer.properties
RUN sed -i -e 's/localhost/mdc-kafka/g' /opt/kafka/config/consumer.properties
RUN sed -i -e 's/104857600/604857600/g' /opt/kafka/config/server.properties