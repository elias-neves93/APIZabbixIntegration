#!/bin/bash

APIKEY=$1
GETTRIGGERCREATED=$(curl -s -k -X POST -H  'Content-Type: application/json' -d @getTriggerCreated https://zabbix.ns2online.com.br/api_jsonrpc.php | jq '.' | jq '.result' | jq '.[]' | jq '.["description"]'
)
LISTAAPPLICATION=$(cat lista.txt)


  for i in $LISTAAPPLICATION; do
    echo $i

    APPLICATTIONID=$(curl -X GET 'https://api.newrelic.com/v2/applications.json' -H 'X-Api-Key:' -G -d 'filter[host]='$i'' | jq '.' | jq '.applications' | jq '.[]' | jq '.id')
    TEMPLATEID=$(curl -s -k -X POST -H  'Content-Type: application/json' -d @getTemplateInHost https://zabbix.ns2online.com.br/api_jsonrpc.php | jq '.' | grep -i $i -B 1 | sed 's/[^0-9]*//g')

      if [ `echo "$GETTRIGGERCREATED" | grep -ci $i` -eq 0 ];
      then

        echo "Sera criado o item e trigger"

        echo "Criando ITEM........"
        #sed 's/ab/~~/g; s/bc/ab/g; s/~~/bc/g'

        # Preparando arquivo auxiliar para criação do ITEM
        sed 's/\[applicationName\]/'$i'/g; s/\[attribute\]/response_time/g; s/\[applicationId\]/'$APPLICATTIONID'/g; s/\[templateId\]/'$TEMPLATEID'/g; s/\[application\]/'$i'/g;' createItemFreedom.json > auxItemFreedom.txt
        # Após formatar o arquivo com os argumentos, realizando requisição POST para API do Zabbix
        curl -k -X POST -i -H  'Content-Type: application/json-rpc' -d @auxItemFreedom.txt https://zabbix.ns2online.com.br/api_jsonrpc.php

        # Realizar o mesmo processo para Error_rate e Throughput

        sed 's/\[applicationName\]/'$i'/g; s/\[attribute\]/error_rate/g; s/\[applicationId\]/'$APPLICATTIONID'/g; s/\[templateId\]/'$TEMPLATEID'/g; s/\[application\]/'$i'/g;' createItemFreedom.json > auxItemFreedom.txt
        # Após formatar o arquivo com os argumentos, realizando requisição POST para API do Zabbix
        curl -k -X POST -i -H  'Content-Type: application/json-rpc' -d @auxItemFreedom.txt https://zabbix.ns2online.com.br/api_jsonrpc.php

        sed 's/\[applicationName\]/'$i'/g; s/\[attribute\]/throughput/g; s/\[applicationId\]/'$APPLICATTIONID'/g; s/\[templateId\]/'$TEMPLATEID'/g; s/\[application\]/'$i'/g;' createItemFreedom.json > auxItemFreedom.txt
        # Após formatar o arquivo com os argumentos, realizando requisição POST para API do Zabbix
        curl -k -X POST -i -H  'Content-Type: application/json-rpc' -d @auxItemFreedom.txt https://zabbix.ns2online.com.br/api_jsonrpc.php


        echo "Criando TRIGGER........"

        GETPOLICIID=$(curl -X GET 'https://api.newrelic.com/v2/alerts_policies.json' -H 'X-Api-Key:' -G -d 'filter[name]='$i'' | jq '.' | jq '.policies' | jq '.[]' | jq '.id')

        THRESHOLD=$()
        NIVEL=$()

        #Preparando aquivo auxiliar para criação da TRIGGER
        sed 's/\[applicationName\]/'$i'/g; s/\[attribute\]/response_time/g; s/\[applicationId\]/'$APPLICATTIONID'/g; s/\[templateId\]/'$TEMPLATEID'/g;'


      else
        echo "Nao vai ser criado NADA"
      fi
  done


#Response_time
#Error_rate
#Throughput
