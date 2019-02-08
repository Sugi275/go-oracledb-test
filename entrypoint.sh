#!/bin/bash

cp -p /wallet/wallet.zip /opt/oracle/instantclient_18_3/network/admin/wallet.zip
cd /opt/oracle/instantclient_18_3/network/admin/
unzip wallet.zip

/home/go-oracledb/go-oracledb-test
exit 0
