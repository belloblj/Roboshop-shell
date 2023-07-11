source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>> CentOS-8 Comes with MySQL 8 Version by default,  our application needs MySQL 5.7. So lets disable MySQL 8 version <<<<<<<<\e[0m"
yum module disable mysql -y

echo -e "\e[36m>>>>>>>> Setup the MySQL5.7 repo file <<<<<<<<\e[0m"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m>>>>>>>> Install MySQL <<<<<<<<\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m>>>>>>>> Start MySQL Service <<<<<<<<\e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[36m>>>>>>>> Change default password <<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1