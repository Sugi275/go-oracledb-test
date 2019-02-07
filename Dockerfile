FROM alpine:3.9
MAINTAINER sugimount <https://twitter.com/sugimount>

# RUN adduser --uid 1000 -D go-oracledb
# USER 1000:1000

# set working directory
WORKDIR /opt/oracle

# instant client
COPY instantclient-basic-linux.x64-18.3.0.0.0dbru.zip /opt/oracle
COPY instantclient-sdk-linux.x64-18.3.0.0.0dbru.zip /opt/oracle
RUN unzip instantclient-basic-linux.x64-18.3.0.0.0dbru.zip && \
    unzip instantclient-sdk-linux.x64-18.3.0.0.0dbru.zip && \
    rm /opt/oracle/instantclient-basic-linux.x64-18.3.0.0.0dbru.zip && \
    rm /opt/oracle/instantclient-sdk-linux.x64-18.3.0.0.0dbru.zip

# go binary
COPY ./bin/go-oracledb-test /home/go-oracledb/go-oracledb-test

EXPOSE 8080
ENTRYPOINT ["/home/go-oracledb/go-oracledb-test"]
