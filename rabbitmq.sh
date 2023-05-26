echo -e "\e[33m Downloading Erlang  \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/robodhop.log
echo -e "\e[33m Downloading Rabitmq \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/robodhop.log
echo -e "\e[33m Installing Rabbitmq \e[0m"
yum install rabbitmq-server -y &>>/tmp/robodhop.log

echo -e "\e[33m Adding Username and password \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/robodhop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/robodhop.log

echo -e "\e[33m Starting Rabitmq server \e[0m"
systemctl enable rabbitmq-server &>>/tmp/robodhop.log
systemctl restart rabbitmq-server &>>/tmp/robodhop.log