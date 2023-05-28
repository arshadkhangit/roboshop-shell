source common.sh
component=catalogue


nodejs


echo -e "${color} copy mongodb repo${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>$log_file
echo -e "${color} Installing Mongodb client${nocolor}"
yum install mongodb-org-shell -y  &>>$log_file
echo -e "${color} Loading schema${nocolor}"
mongo --host mongodb-dev.arshadev.online <${app_path}/schema/$component.js  &>>$log_file


