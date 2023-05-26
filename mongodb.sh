echo -e "\e[33mcopy mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/robodhop.log
echo -e "\e[33minstalling mongodb server\e[0m"
yum install mongodb-org -y &>>/tmp/robodhop.log

echo -e "\e[33m updating mongodb config\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e "\e[33m starting mongodb server\e[0m"
systemctl enable mongod &>>/tmp/robodhop.log
systemctl restart mongod &>>/tmp/robodhop.log