#!/bin/bash

if [ -f /opt/oracle/instantclient_18_3/network/admin/wallet.zip ]; then
  echo "wallet.zip is exist. skip unzip."
else
  cp -p /wallet/wallet.zip /opt/oracle/instantclient_18_3/network/admin/wallet.zip
  cd /opt/oracle/instantclient_18_3/network/admin/
  unzip wallet.zip
fi

/home/go-oracledb/go-oracledb-test
exit 0
