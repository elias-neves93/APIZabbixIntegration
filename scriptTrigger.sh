#!/bin/bash

FILAS=$(cat lista.txt)

  for i in $FILAS;do
    sed 's/teste/'$i'/g' auxTrigger.txt > auxTriggerR.txt
    curl -X POST -i -H  'Content-Type: application/json-rpc' -d @auxTriggerR.txt 192.168.0.29/zabbix/api_jsonrpc.php
  done
