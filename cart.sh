echo -e\ "\e[33m Downloading the NodeJS\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/robodhop.log

echo  -e "e\[33m Installing the NodeJS\e[0m"
yum install nodejs -y &>>/tmp/robodhop.log

echo -e "e\[33m Adding cart Roboshop\e[0m"
useradd roboshop &>>/tmp/robodhop.log


rm -rf app
echo -e "e\[33m Adding Directory\e[0m"
mkdir /app
echo -e "e\[33m Downloading cart file\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/robodhop.log
cd /app
echo -e "e\[33m extracting cart file\e[0m"
unzip /tmp/cart.zip &>>/tmp/robodhop.log

cd /app
echo -e "e\[33m installing npm\e[0m"
npm install &>>/tmp/robodhop.log
echo -e "e\[33m copy cart service file\e[0m"
cp cart.service /etc/systemd/system/cart.service &>>/tmp/robodhop.log
systemctl daemon-reload  &>>/tmp/robodhop.log
systemctl enable cart  &>>/tmp/robodhop.log
systemctl restart cart  &>>/tmp/robodhop.log
