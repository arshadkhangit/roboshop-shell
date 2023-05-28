
echo -e "\e[33m Installing Golang  \e[0m"
yum install golang -y &>>/tmp/robodhop.log


echo -e "\e[33m Adding user\e[0m"
useradd roboshop &>>/tmp/robodhop.log


rm -rf /app
echo -e "\e[33m Adding Directory\e[0m"
mkdir /app
echo -e "\e[33m Downloading dispatch file\e[0m"
curl -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/robodhop.log
cd /app
echo -e "\e[33m extracting dispatch file\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/robodhop.log
echo -e "\e[33m  \e[0m"
cd /app &>>/tmp/robodhop.log
go mod init dispatch &>>/tmp/robodhop.log
go get &>>/tmp/robodhop.log
go build &>>/tmp/robodhop.log
echo -e "\e[33m Starting of Dispatch server \e[0m"
systemctl daemon-reload &>>/tmp/robodhop.log
systemctl enable dispatch &>>/tmp/robodhop.log
systemctl restart dispatch &>>/tmp/robodhop.log