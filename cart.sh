script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head() {
  echo -e "\e[36m>>>>>>>> $* <<<<<<<<\e[0m"
}

print_head "Setup NodeJS Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

print_head "Install NodeJS"
yum install nodejs -y

print_head "Add Application User"
useradd ${app_user}

print_head "Create Application Directory"
rm -rf /app
mkdir /app

print_head "Download App Content"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

print_head "Unzip App Content"
unzip /tmp/cart.zip

print_head "Install NodeJS Dependencies"
npm install

print_head "Unzip App Content"
cp ${script_path}/cart.service /etc/systemd/system/cart.service

print_head "Start Cart Service"
systemctl daemon-reload
systemctl enable cart
systemctl start cart