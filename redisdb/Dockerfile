FROM redis

RUN apt-get update
RUN apt-get install -y awscli

ARG DB_PASSWORD

ENV DB_PASSWORD=$DB_PASSWORD

RUN mkdir -p /usr/local/etc/redis

RUN echo "requirepass $DB_PASSWORD" > /usr/local/etc/redis/redis.conf

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]