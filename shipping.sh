source common.sh

echo -e "\e[36m>>>>>>>> Install Maven <<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>>> Add User <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>> Create Application Directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>> Download Application code to Directory <<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

echo -e "\e[36m>>>>>>>> Unzip file <<<<<<<<\e[0m"
cd /app
unzip /tmp/shipping.zip

echo -e "\e[36m>>>>>>>> Download Maven Dependencies and Build Application <<<<<<<<\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[36m>>>>>>>> Copy and SetUp Shipping.service file into SystemD <<<<<<<<\e[0m"
cp /root/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service


echo -e "\e[36m>>>>>>>> Install MySQL Client <<<<<<<<\e[0m"
yum install mysql -y

echo -e "\e[36m>>>>>>>> Load Schema <<<<<<<<\e[0m"
mysql -h mysql.robobello.shop -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[36m>>>>>>>> Restart Shipping Service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping