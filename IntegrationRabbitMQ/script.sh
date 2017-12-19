#!/bin/bash

FILAS=$(cat lista.txt)

  for i in $FILAS;do
    sed 's/teste/'$i'/g' auxItem.txt > auxItemR.txt
    curl -k -X POST -i -H  'Content-Type: application/json-rpc' -d @auxItemR.txt https://zabbix.ns2online.com.br/api_jsonrpc.php
  done
