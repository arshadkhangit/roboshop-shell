echo -e "\e[33mcop mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[33minstalling mongodb server\e[0m"
yum install mongodb-org -y

#modify the config file
echo -e "\e[33mstarting mongodb server\e[0m"
systemctl enable mongod
systemctl restart mongod