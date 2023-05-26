

yum install python36 gcc python3-devel -y &>>/tmp/robodhop.log


echo -e "\e[33m Adding user\e[0m"
useradd roboshop &>>/tmp/robodhop.log


rm -rf app
echo -e "\e[33m Adding Directory\e[0m"
mkdir /app
echo -e "\e[33m Downloading Payment file\e[0m"
curl -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/robodhop.log
cd /app
echo -e "\e[33m extracting payment file\e[0m"
unzip /tmp/payment.zip &>>/tmp/robodhop.log


echo -e "\e[33m Starting payment server\e[0m"
systemctl daemon-reload  &>>/tmp/robodhop.log
systemctl enable payment  &>>/tmp/robodhop.log
systemctl restart payment  &>>/tmp/robodhop.log
