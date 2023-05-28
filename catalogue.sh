component=catalogue
color="\e[35m"
nocolor="\e[0m"


echo -e "${color} Configuring the NodeJS${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/robodhop.log

echo  -e "${color} Installing the NodeJS${nocolor}"
yum install nodejs -y &>>/tmp/robodhop.log

echo -e "${color} Adding User Roboshop${nocolor}"
useradd roboshop &>>/tmp/robodhop.log

rm -rf /app
echo -e "${color} Adding Directory${nocolor}"
mkdir /app
echo -e "${color} Downloading $component file${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/robodhop.log
cd /app
echo -e "${color} extracting $component file${nocolor}"
unzip /tmp/$component.zip &>>/tmp/robodhop.log

cd /app
echo -e "${color} installing npm${nocolor}"
npm install &>>/tmp/robodhop.log
echo -e "${color} copy $component service file${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/robodhop.log
echo -e "${color} Starting $component${nocolor}"
systemctl daemon-reload &>>/tmp/robodhop.log
systemctl enable $component &>>/tmp/robodhop.log
systemctl restart $component &>>/tmp/robodhop.log
echo -e "${color} copy mongodb repo${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/robodhop.log
echo -e "${color} Installing Mongodb client${nocolor}"
yum install mongodb-org-shell -y  &>>/tmp/robodhop.log
echo -e "${color} Loading schema${nocolor}"
mongo --host mongodb-dev.arshadev.online </app/schema/$component.js  &>>/tmp/robodhop.log


