app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

func_print_head() {
  func_print_head"\e[36m>>>>>>>> $1 <<<<<<<<\e[0m"
}

func_schema_setup() {
  if [ "$schema_setup" == "mongo" ]; then
    func_print_head "Copy MongoDB Repo"
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

    func_print_head "Install MongoDB Client"
    yum install mongodb-org-shell -y

    func_print_head "Load Schema"
    mongo --host mongodb.robobello.shop </app/schema/${component}.js

  fi

  if [ "$schema_setup" == "mysql" ]; then
      func_print_head "Install MySQL Client"
      yum install mysql -y

      func_print_head "Load Schema"
      mysql -h mysql-dev.rdevopsb72.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql

  fi
}

func_app_prereq() {
    func_print_head "Add Application User"
    useradd ${app_user}

    func_print_head "Create Application Directory"
    rm -rf /app
    mkdir /app

    func_print_head "Download App Content"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app

    func_print_head "Unzip App Content"
    unzip /tmp/${component}.zip
}

func_systemd_setup() {
  func_print_head "Setup SystemD Service"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

  func_print_head "Start ${component} Service"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
}

func_nodejs() {
  func_print_head "Setup NodeJS Repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "Install NodeJS"
  yum install nodejs -y

  func_app_prereq

  func_print_head "Install NodeJS Dependencies"
  npm install

  func_print_head "Unzip App Content"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

  func_schema_setup
  func_systemd_setup


}

func_java() {
  func_print_head "Install Maven"
  yum install maven -y

  func_app_prereq

  func_print_head "Download Maven Dependencies and Build Application"
  mvn clean package
  mv target/${component}-1.0.jar ${component}.jar

  func_schema_setup

  func_systemd_setup
}
