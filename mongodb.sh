echo -e "\e[33mcop mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/robodhop.log
echo -e "\e[33minstalling mongodb server\e[0m"
yum install mongodb-org -y &>>/tmp/robodhop.log

#modify the config file
echo -e "\e[33mstarting mongodb server\e[0m"
systemctl enable mongod &>>/tmp/robodhop.log
systemctl restart mongod &>>/tmp/robodhop.log