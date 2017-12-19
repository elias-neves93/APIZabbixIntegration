#!/bin/bash

FILAS=$(cat lista.txt)

  for i in $FILAS;do
    sed 's/teste/'$i'/g' auxTrigger.txt > auxTriggerR.txt
    curl -k -X POST -i -H  'Content-Type: application/json-rpc' -d @auxTriggerR.txt https://zabbix.ns2online.com.br/api_jsonrpc.php
  done
