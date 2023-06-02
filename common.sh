color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/robodhop.log"
app_path="/app"
user_id=$(id -u)
if [ $user_id -ne 0 ]; then
  echo script should be run as sudo
  exit 1
fi

stat_check() {
  if [ $1 -eq 0 ]; then
    echo success
  else
    echo failure
    exit 1
  fi
}
app_presetup() {
  echo -e "${color} Adding User Roboshop ${nocolor}"
  id roboshop &>>$log_file
  if [ $? -eq 1 ]; then
    useradd roboshop &>>$log_file
  fi
  stat_check $?

  echo -e "${color} Creating Directory ${nocolor}"
  rm -rf ${app_path} &>>$log_file
  mkdir ${app_path} &>>$log_file

  stat_check $?

  echo -e "${color} Downloading $component file ${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
  stat_check $?

  echo -e "${color} extracting $component file ${nocolor}"
  cd ${app_path}
  unzip /tmp/$component.zip &>>$log_file
  stat_check $?

}

systemd_setup() {
  echo -e "${color} copy $component service file${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
  sed -i -e "s/roboshop_app_password/$roboshop_app_password/" /etc/systemd/system/$component.service
  stat_check $?

  echo -e "${color} Starting $component${nocolor}"
  systemctl daemon-reload &>>$log_file
  systemctl enable $component &>>$log_file
  systemctl restart $component &>>$log_file
  stat_check $?
}


nodejs() {
  echo -e "${color} Configuring the NodeJS${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  stat_check $?
  echo  -e "${color} Installing the NodeJS${nocolor}"
  yum install nodejs -y &>>$log_file
  stat_check $?
  app_presetup

  echo -e "${color} installing npm${nocolor}"
  npm install &>>$log_file
  stat_check $?
  systemd_setup
}

mongo_schema_setup() {
  echo -e "${color} Copy MongoDB Repo file ${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>$log_file
  stat_check $?

  echo -e "${color} Install MongoDB Client ${nocolor}"
  yum install mongodb-org-shell -y  &>>$log_file
  stat_check $?

  echo -e "${color} Load Schema ${nocolor}"
  mongo --host mongodb-dev.arshadev.online <${app_path}/schema/$component.js  &>>$log_file
  stat_check $?
}

mysql_schema_setup() {
  echo -e "${color} Installing Mysql client ${nocolor}"
  yum install mysql -y &>>$log_file
  stat_check $?
  echo -e "${color} Loading Schema ${nocolor}"
  mysql -h mysql-dev.arshadev.online -uroot -p${mysql_root_password} <${app_path}/schema/$component.sql &>>$log_file
  stat_check $?
}


maven() {
  echo -e "${color} Installing Maven ${nocolor}"
  yum install maven -y &>>$log_file
  stat_check $?

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

  stat_check $?

  app_presetup

  echo -e "${color} Downloading and Installing Dependencies ${nocolor}"
  cd ${app_path} &>>$log_file
  pip3.6 install -r requirements.txt &>>$log_file
  stat_check $?
  systemd_setup
}