echo -e "\e[36m>>>>>>>> Setup NodeJS Repos <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>> Install NodeJS <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>> Add User <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>> Setup app Directory <<<<<<<<\e[0m"
mkdir /app

echo -e "\e[36m>>>>>>>> Download Application code to App Directory <<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

echo -e "\e[36m>>>>>>>> Download Dependencies <<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>>> Copy User.service file <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>>> Load User Service <<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>>> Enable User Service <<<<<<<<\e[0m"
systemctl enable user

echo -e "\e[36m>>>>>>>> Start User Service <<<<<<<<\e[0m"
systemctl start user

echo -e "\e[36m>>>>>>>> Copy MongoDB Client <<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>> Install MongoDB Client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>> Load Schema <<<<<<<<\e[0m"
mongo --host mongodb.robobello.shop </app/schema/user.js