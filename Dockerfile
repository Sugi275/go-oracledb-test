FROM ubuntu:18.04 
MAINTAINER sugimount <https://twitter.com/sugimount>

# set working directory
WORKDIR /opt/oracle

# package install
RUN apt-get update && \
    apt-get install -y wget unzip libaio1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# instant client
RUN wget https://github.com/Sugi275/go-oracledb-test/raw/master/instantclient-basic-linux.x64-18.3.0.0.0dbru.zip && \
    unzip instantclient-basic-linux.x64-18.3.0.0.0dbru.zip && \
    rm /opt/oracle/instantclient-basic-linux.x64-18.3.0.0.0dbru.zip

# runtime linkpath
COPY oracle-instantclient.conf /etc/ld.so.conf.d/oracle-instantclient.conf
RUN ldconfig

# Wallet
# COPY Wallet_tutorial1.zip /opt/oracle/instantclient_18_3/network/admin/Wallet_tutorial1.zip
# RUN cd /opt/oracle/instantclient_18_3/network/admin/ && \
#     unzip Wallet_tutorial1.zip

# user add
RUN adduser --uid 1000 go-oracledb && \
    chown go-oracledb: /opt/oracle/instantclient_18_3/network/admin

# go binary
COPY ./bin/go-oracledb-test /home/go-oracledb/go-oracledb-test

# entrypoint shell
COPY entrypoint.sh /home/go-oracledb/entrypoint.sh
RUN chown go-oracledb: /home/go-oracledb/entrypoint.sh

# default user
USER 1000:1000

EXPOSE 8080
ENTRYPOINT ["sh", "/home/go-oracledb/entrypoint.sh"]
