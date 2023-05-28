echo -e "\e[33m Downloading Node repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[33m Installing Node js\e[0m"
yum install nodejs -y
echo -e "\e[33m adding user \e[0m"
useradd roboshop

echo -e "\e[33m Creating a Directory\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[33m Dowanloading cart file \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip

echo -e "\e[33m Installing application \e[0m"
cd /app
npm install


echo -e "\e[33m copy service file\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service


echo -e "\e[33m starting cart server \e[0m"
systemctl daemon-reload

systemctl enable cart
systemctl start cart