# What does it do?

Creates a new host in which the HOST NAME will be the name of the service that we want to monitor and the DNS NAME will be the host where the service is running, well, it will actually be the first hop which is serving SSL certificate, it could be a reverse proxy serving several websites or a single webserver that serves either one or multiple websites

After Creating the host, it will also set it to maintenance for 10 minutes. This might be useful if we want to 

# Requissits

It has been tested with Python 2.7 and it is working. We'll install Python pip, upgrade it with pip itself, funny, isn't it?  then install then needed libraries. 

```
sudo apt install python-pip
pip install --upgrade pip
pip install pyyaml
sudo apt-get install python-urllib3
git clone https://github.com/danitfk/zabbix-add-host-api
```

# Usage

* After cloning the repo, we see that there is a gitignore file, so that allows us to copy the desired config.py[test-prod] to config.py and work with it.
* Simply adapt the config.py file to your needs , depending what system you want to insert the SSL monitoring check to.
* Use it without providing any port, which means the script checking the certificate from the Zabbix server will go for port 443
```
python zabbix_create_host_api.py cloud.example.com opscl01.example.com 172.20.16.1
```
## IMPORT MASSIVE OF HOSTS
If you want import a massive number of hosts it will take much time to run command for single host. To avoid this, You can create an CSV file called **`servers.csv`** with bellow format and run the Bash script **zadd.sh**.

Example format of **servers.csv** :

```
cloud1.example.com,opscl01.example.com,172.20.16.1
cloud2.example.com,opscl02.example.com,172.20.16.2
cloud3.example.com,opscl02.example.com,172.20.16.3

```
then just run the Bash Script to add hosts in servers.csv

``bash ./zadd.sh``


* It doesn't support SSL Port for servers.csv.1


* Specify a different port and this script will add a MACRO on the Zabbix host that will make the SSL checker to check in that specific port.
```
python zabbix_create_host_api.py cloud.example.com opscl01.example.com 172.20.16.1 4443
```

