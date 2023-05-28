color="\e[32m"
nocolor="\e[0m"
log_file="/tmp/robodhop.log"
app_path="/app"


nodejs() {
  echo -e "${color} Configuring the NodeJS${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

  echo  -e "${color} Installing the NodeJS${nocolor}"
  yum install nodejs -y &>>$log_file

  echo -e "${color} Adding User Roboshop${nocolor}"
  useradd roboshop &>>$log_file

  rm -rf ${app_path}
  echo -e "${color} Adding Directory${nocolor}"
  mkdir ${app_path}
  echo -e "${color} Downloading $component file${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
  cd ${app_path}
  echo -e "${color} extracting $component file${nocolor}"
  unzip /tmp/$component.zip &>>$log_file

  cd ${app_path}
  echo -e "${color} installing npm${nocolor}"
  npm install &>>$log_file
  echo -e "${color} copy $component service file${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
  echo -e "${color} Starting $component${nocolor}"
  systemctl daemon-reload &>>$log_file
  systemctl enable $component &>>$log_file
  systemctl restart $component &>>$log_file
}