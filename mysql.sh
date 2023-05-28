echo -e "\e[33m Disabling mysql older version \e[0m"
yum module disable mysql -y &>>/tmp/robodhop.log

echo -e "\e[33m Copy MySQL repo file \e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo  &>>/tmp/roboshop.log

echo -e "\e[33m Installing mysql community server \e[0m"
yum install mysql-community-server -y &>>/tmp/robodhop.log


echo -e "\e[33m mysql server starting \e[0m"
systemctl enable mysqld &>>/tmp/robodhop.log
systemctl restart mysqld &>>/tmp/robodhop.log

echo -e "\e[33m seting up  passwd \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/robodhop.log

