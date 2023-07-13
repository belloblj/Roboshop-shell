script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

if [  [ -z "$rabbitmq_appuser_password" ] ]; then
  echo Input RabbitMQ AppUser Password Missing
  exit
fi

echo -e "\e[36m>>>>>>>> Install Python 3.6 <<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>>> Add User <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>> Create App directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>> Download Application Code to Directory <<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo -e "\e[36m>>>>>>>> Unzip Payment App file <<<<<<<<\e[0m"
cd /app
unzip /tmp/payment.zip

echo -e "\e[36m>>>>>>>> Download Dependencies <<<<<<<<\e[0m"
sed -i -e "s/rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/paymen.service
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>> Copy Payment service files <<<<<<<<\e[0m"
cp ${script_path}/payment.service /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>>> Load & Start Payment Service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment