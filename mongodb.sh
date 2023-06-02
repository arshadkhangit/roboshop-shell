source common.sh
echo -e "${color} copy mongodb repo${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} installing mongodb server${nocolor}"
yum install mongodb-org -y  &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} updating mongodb config${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat_check $?

echo -e "${color} starting mongodb server${nocolor}"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
stat_check $?
