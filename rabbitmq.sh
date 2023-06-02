source common.sh

echo -e "${color} Downloading Erlang  ${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_file
stat_check $?

echo -e "${color} Downloading Rabitmq ${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_file
stat_check $?

echo -e "${color} Installing Rabbitmq ${nocolor}"
yum install rabbitmq-server -y &>>$log_file
stat_check $?

echo -e "${color} Starting Rabitmq server ${nocolor}"
systemctl enable rabbitmq-server &>>$log_file
systemctl restart rabbitmq-server &>>$log_file
stat_check $?

echo -e "${color} Adding Username and password ${nocolor}"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log
stat_check $?
