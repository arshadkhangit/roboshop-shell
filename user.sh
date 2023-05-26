
echo -e "\e[33m Downloading the NodeJS\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/robodhop.log

echo  -e "\e[33m Installing the NodeJS\e[0m"
yum install nodejs -y &>>/tmp/robodhop.log

echo -e "\e[33m Adding User \e[0m"
useradd roboshop &>>/tmp/robodhop.log



echo -e "\e[33m Adding Directory\e[0m"
rm -rf app
mkdir /app
echo -e "\e[33m Downloading user file\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/robodhop.log
cd /app
echo -e "\e[33m extracting user file\e[0m"
unzip /tmp/user.zip &>>/tmp/robodhop.log


echo -e "\e[33m installing npm\e[0m"
npm install &>>/tmp/robodhop.log
echo -e "\e[33m copy user service file\e[0m"
cp user.service /etc/systemd/system/user.service &>>/tmp/robodhop.log
systemctl daemon-reload
echo -e "\e[33m copy mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[33m Installing Mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/robodhop.log
echo -e "\e[33m Loading schema\e[0m"
mongo --host mongodb-dev.arshadev.online </app/schema/user.js &>>/tmp/robodhop.log
echo -e "\e[33m Starting user\e[0m"
systemctl enable user &>>/tmp/robodhop.log
systemctl restart user &>>/tmp/robodhop.log