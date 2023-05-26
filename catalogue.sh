echo -e\ "\e[33m Downloading the NodeJS\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo  -e "e\[33m Installing the NodeJS\e[0m"
yum install nodejs -y

echo -e "e\[33m Adding User Roboshop\e[0m"
useradd roboshop


rm -rf app
echo -e "e\[33m Adding Directory\e[0m"
mkdir /app
echo -e "e\[33m Downloading catalogue file\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "e\[33m extracting catalogue file\e[0m"
unzip /tmp/catalogue.zip

cd /app
echo -e "e\[33m installing npm\e[0m"
npm install
echo -e "e\[33m copy catalogue service file\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
echo -e "e\[33m copy mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "e\[33m Installing Mongodb client\e[0m"
yum install mongodb-org-shell -y
echo -e "e\[33m Loading schema\e[0m"
mongo --host mongodb-dev.arshadev.online </app/schema/catalogue.js
echo -e "e\[33m Starting Catalogue\e[0m"
systemctl enable catalogue
systemctl restart catalogue