component=catalogue
echo -e "\e[33m Configuring the NodeJS\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/robodhop.log

echo  -e "\e[33m Installing the NodeJS\e[0m"
yum install nodejs -y &>>/tmp/robodhop.log

echo -e "\e[33m Adding User Roboshop\e[0m"
useradd roboshop &>>/tmp/robodhop.log

rm -rf /app
echo -e "\e[33m Adding Directory\e[0m"
mkdir /app
echo -e "\e[33m Downloading $component file\e[0m"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/robodhop.log
cd /app
echo -e "\e[33m extracting $component file\e[0m"
unzip /tmp/$component.zip &>>/tmp/robodhop.log

cd /app
echo -e "\e[33m installing npm\e[0m"
npm install &>>/tmp/robodhop.log
echo -e "\e[33m copy $component service file\e[0m"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/robodhop.log
echo -e "\e[33m Starting $component\e[0m"
systemctl daemon-reload &>>/tmp/robodhop.log
systemctl enable $component &>>/tmp/robodhop.log
systemctl restart $component &>>/tmp/robodhop.log
echo -e "\e[33m copy mongodb repo\e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/robodhop.log
echo -e "\e[33m Installing Mongodb client\e[0m"
yum install mongodb-org-shell -y  &>>/tmp/robodhop.log
echo -e "\e[33m Loading schema\e[0m"
mongo --host mongodb-dev.arshadev.online </app/schema/$component.js  &>>/tmp/robodhop.log


