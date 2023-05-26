
echo -e "e\[33m Installing Golang  \e[0m"
yum install golang -y


echo -e "e\[33m Adding user\e[0m"
useradd roboshop &>>/tmp/robodhop.log


rm -rf app
echo -e "e\[33m Adding Directory\e[0m"
mkdir /app
echo -e "e\[33m Downloading dispatch file\e[0m"
curl -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/robodhop.log
cd /app
echo -e "e\[33m extracting dispatch file\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/robodhop.log
echo -e "e\[33m  \e[0m"
cd /app
go mod init dispatch
go get
go build
echo -e "e\[33m Starting of Dispatch server \e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch