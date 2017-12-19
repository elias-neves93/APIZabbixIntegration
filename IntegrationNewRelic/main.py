#!/usr/bin/python

import sys
from pyzabbix import ZabbixAPI

#api_key=str(sys.argv[1])

zapi = ZabbixAPI("http://zabbix.ns2online.com.br")
zapi.session.verify = False
zapi.login("monitoracao", "Senha1234")


zapi.timeout = 5.1

print ("Conectado %s" % zapi.api_version())

#for h in zapi.host.get(output="extend"):
#    print(h['hostid']