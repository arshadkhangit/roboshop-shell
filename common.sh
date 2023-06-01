color="\e[31m"
nocolor="${nocolor}"
log_file="/tmp/robodhop.log"
app_path="/app"

app_presetup(){
  echo -e "${color} Adding User Roboshop${nocolor}"
  useradd roboshop &>>$log_file
  echo $?

  echo -e "${color} Creating Directory ${nocolor}"
  rm -rf ${app_path} &>>$log_file
  mkdir ${app_path} &>>$log_file
  echo $?

  echo -e "${color} Downloading $component file${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
  cd ${app_path}
  echo $?

  echo -e "${color} extracting $component file${nocolor}"
  cd ${app_path}
  unzip /tmp/$component.zip &>>$log_file
  echo $?
}

systemd_setup(){
  echo -e "${color} copy $component service file${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
  echo $?
  echo -e "${color} Starting $component${nocolor}"
  systemctl daemon-reload &>>$log_file
  systemctl enable $component &>>$log_file
  systemctl restart $component &>>$log_file
  echo $?
}


nodejs() {
  echo -e "${color} Configuring the NodeJS${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

  echo  -e "${color} Installing the NodeJS${nocolor}"
  yum install nodejs -y &>>$log_file

  app_presetup

  echo -e "${color} installing npm${nocolor}"
  npm install &>>$log_file

  systemd_setup
}

mongo_schema_setup(){
  echo -e "${color} Copy MongoDB Repo file ${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>$log_file

  echo -e "${color} Install MongoDB Client ${nocolor}"
  yum install mongodb-org-shell -y  &>>$log_file

  echo -e "${color} Load Schema ${nocolor}"
  mongo --host mongodb-dev.arshadev.online.store <${app_path}/schema/$component.js  &>>$log_file
}

mysql_schema_setup(){
  echo -e "${color} Installing Mysql client ${nocolor}"
  yum install mysql -y &>>$log_file

  echo -e "${color} Loading Schema ${nocolor}"
  mysql -h mysql-dev.arshadev.online -uroot -pRoboShop@1 < ${app_path}/schema/$component.sql &>>$log_file
}

maven(){
  echo -e "${color} Installing Maven ${nocolor}"
  yum install maven -y &>>$log_file

  app_presetup

  echo -e "${color} Cleaning package ${nocolor}"
  mvn clean package &>>$log_file
  mv target/$component-1.0.jar $component.jar &>>$log_file

  mysql_schema_setup

  systemd_setup
}
python(){
  echo -e "${color} Installing Python36 ${nocolor}"
  yum install python36 gcc python3-devel -y &>>$log_file
  echo $?

  app_presetup

  echo -e "${color} Downloading and Installing Dependencies${nocolor}"
  cd ${app_path} &>>$log_file
  pip3.6 install -r requirements.txt &>>$log_file
  echo $?

  systemd_setup
}