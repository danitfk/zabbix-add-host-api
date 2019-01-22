#!/bin/bash

if [ ! -f ./servers.csv ]
then
	echo "servers.csv not found."
	echo "example: cloud.example.com,opscl01.example.com,172.20.16.1"
	exit 1
fi
## Check first line of servers.txt
LINE=$(wc -l ./servers.csv | awk {'print $1'})
for line in `eval echo {1..$LINE}`
do
	TEST=$(head -n $line servers.csv | tail -n1 | grep -o "," | wc -l)
	if [ "$TEST" -lt 2 ]
	then
		echo "Error in line: $line"
		echo "servers.txt doesn't have proper format"
		echo "example: cloud.example.com,opscl01.example.com,172.20.16.1"
		exit 1
	fi


done
for HOST in `cat ./servers.csv`
do
	host_name=$(echo $HOST | cut -d"," -f1)
	host_dns=$(echo $HOST | cut -d"," -f2)
	host_ipaddr=$(echo $HOST | cut -d"," -f3)
	python zabbix_create_host_api.py "$host_name" "$host_dns" "$host_ipaddr"
	if [ $? -gt 0 ]; then
		echo "Error on $HOST"
		exit 1
	fi
done

exit 0
