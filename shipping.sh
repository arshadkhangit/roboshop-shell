
echo -e "\e[33m Installing Maven \e[0m"
yum install maven -y &>>/tmp/robodhop.log
echo -e "\e[33m Adding user \e[0m"
useradd roboshop &>>/tmp/robodhop.log
echo -e "\e[33m Creating Directory \e[0m"
rm -rf app &>>/tmp/robodhop.log
mkdir /app &>>/tmp/robodhop.log
echo -e "\e[33m Downloading Shipping file \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/robodhop.log

cd /app &>>/tmp/robodhop.log &>>/tmp/robodhop.log
echo -e "\e[33m Extracting Shipping file \e[0m"
unzip /tmp/shipping.zip &>>/tmp/robodhop.log

echo -e "\e[33m Cleaning package \e[0m"
cd /app &>>/tmp/robodhop.log
mvn clean package &>>/tmp/robodhop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/robodhop.log




echo -e "\e[33m Installing Mysql client \e[0m"
yum install mysql -y &>>/tmp/robodhop.log
echo -e "\e[33m Loading Schema \e[0m"
mysql -h mysql-dev.arshadev.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/robodhop.log

echo -e "\e[33m starting Shipping server \e[0m"
systemctl enable shipping &>>/tmp/robodhop.log
systemctl restart shipping &>>/tmp/robodhop.log