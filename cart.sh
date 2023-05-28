echo -e "\e[33m Downloading Node repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/robodhop.log
echo -e "\e[33m Installing Node js\e[0m"
yum install nodejs -y  &>>/tmp/robodhop.log
echo -e "\e[33m adding user \e[0m"
useradd roboshop  &>>/tmp/robodhop.log

echo -e "\e[33m Creating a Directory\e[0m"
rm -rf /app  &>>/tmp/robodhop.log
mkdir /app  &>>/tmp/robodhop.log
echo -e "\e[33m Dowanloading cart file \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>>/tmp/robodhop.log
cd /app  &>>/tmp/robodhop.log
unzip /tmp/cart.zip  &>>/tmp/robodhop.log

echo -e "\e[33m Installing application \e[0m"
cd /app  &>>/tmp/robodhop.log
npm install  &>>/tmp/robodhop.log


echo -e "\e[33m copy service file\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service  &>>/tmp/robodhop.log


echo -e "\e[33m starting cart server \e[0m"
systemctl daemon-reload  &>>/tmp/robodhop.log
systemctl enable cart  &>>/tmp/robodhop.log
systemctl start cart  &>>/tmp/robodhop.log