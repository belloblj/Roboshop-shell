echo -e "\e[36m>>>>>>>> Install GoLang <<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[36m>>>>>>>> Add Application User <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>> Setup Application Directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>> Download Application Code <<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip

echo -e "\e[36m>>>>>>>> Unzip Application file <<<<<<<<\e[0m"
cd /app
unzip /tmp/dispatch.zip

echo -e "\e[36m>>>>>>>> Download GoLang Dependencies & Build App <<<<<<<<\e[0m"
go mod init dispatch
go get
go build

echo -e "\e[36m>>>>>>>> Copy Dispatch Service file  <<<<<<<<\e[0m"
cp /root/Roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[36m>>>>>>>> Load Service <<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>>> Enable & Start Service <<<<<<<<\e[0m"
systemctl enable dispatch
systemctl start dispatch