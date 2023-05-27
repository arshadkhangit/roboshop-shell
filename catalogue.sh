echo -e "\e[33m Configuring the NodeJS\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/robodhop.log

echo  -e "\e[33m Installing the NodeJS\e[0m"
yum install nodejs -y &>>/tmp/robodhop.log

echo -e "\e[33m Adding User Roboshop\e[0m"
useradd roboshop &>>/tmp/robodhop.log


rm -rf /app
echo -e "\e[33m Adding Directory\e[0m"
mkdir /app
echo -e "\e[33m Downloading catalogue file\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/robodhop.log
cd /app
echo -e "\e[33m extracting catalogue file\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/robodhop.log

cd /app
echo -e "\e[33m installing npm\e[0m"
npm install &>>/tmp/robodhop.log
echo -e "\e[33m copy catalogue service file\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/robodhop.log
echo -e "\e[33m Starting Catalogue\e[0m"
systemctl daemon-reload &>>/tmp/robodhop.log
systemctl enable catalogue &>>/tmp/robodhop.log
systemctl restart catalogue &>>/tmp/robodhop.log
echo -e "\e[33m copy mongodb repo\e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/robodhop.log
echo -e "\e[33m Installing Mongodb client\e[0m"
yum install mongodb-org-shell -y  &>>/tmp/robodhop.log
echo -e "\e[33m Loading schema\e[0m"
mongo --host mongodb-dev.arshadev.online </app/schema/catalogue.js  &>>/tmp/robodhop.log


