#!/bin/bash

APIKEY=$1
GETTRIGGERCREATED=$(curl -s -k -X POST -H  'Content-Type: application/json' -d @getTriggerCreated https://zabbix.ns2online.com.br/api_jsonrpc.php | jq '.' | jq '.result' | jq '.[]' | jq '.["description"]'
)
LISTAAPPLICATION=$(cat lista.txt)


for i in $LISTAAPPLICATION; do
  echo $i
  if ( `$GETTRIGGERCREATED | grep -c $i` = 0 );
  then
    $(echo "Sera criado o item e trigger")
  fi

  #$(echo "Nao vai ser criado NADA")
