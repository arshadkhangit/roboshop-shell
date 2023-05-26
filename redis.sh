echo -e "\e[33m installing Redis repo\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[33m Enabling Redis version\e[0m"
yum module enable redis:remi-6.2 -y
echo -e "\e[33m Installing Redis\e[0m"
yum install redis -y
sep -i 's/127.0.0.0/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf

echo -e "\e[33m Starting Redis Server\e[0m"
systemctl enable redis
systemctl restart redis