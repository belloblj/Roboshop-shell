echo -e "\e[36m>>>>>>>> Install Redis Repos <<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[36m>>>>>>>> Enable Redis6.2 Package <<<<<<<<\e[0m"
yum module enable redis:remi-6.2 -y

echo -e "\e[36m>>>>>>>> Install Redis <<<<<<<<\e[0m"
yum install redis -y

echo -e "\e[36m>>>>>>>> Update listen address from 127.0.0.1 to 0.0.0.0 <<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf
## cp redis.conf /etc/redis.conf

echo -e "\e[36m>>>>>>>> Enable and Start Redis <<<<<<<<\e[0m"
systemctl enable redis
systemctl start redis