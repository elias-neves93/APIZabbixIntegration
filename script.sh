#!/bin/bash

FILAS=$(cat lista.txt)

  for i in $FILAS;do
    sed 's/teste/'$i'/g' auxItem.txt > auxItemR.txt
    curl -X POST -i -H  'Content-Type: application/json-rpc' -d @auxItemR.txt 192.168.0.28/zabbix/api_jsonrpc.php
  done
