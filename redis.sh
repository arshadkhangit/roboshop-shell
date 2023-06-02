source common.sh
echo -e "${color} installing Redis repo${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$log_file
stat_check $?

echo -e "${color} Enabling Redis version${nocolor}"
yum module enable redis:remi-6.2 -y  &>>$log_file
stat_check $?
echo -e "${color} Installing Redis${nocolor}"
yum install redis -y &>>$log_file
stat_check $?
echo -e "${color} Updating redis listen address${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log
stat_check $?
echo -e "${color} Start Redis Server${nocolor}"
systemctl enable redis &>>$log_file
systemctl restart redis &>>$log_file
stat_check $?