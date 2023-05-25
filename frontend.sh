echo -e "\e[33minstalling nginx server\e[0m"
yum install nginx -y &>>/tmp/robodhop.log
echo -e "\e[33mremoving old app content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/robodhop.log

echo -e "\e[33mdownloading frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/robodhop.log

echo -e "\e[33mextraacting frontend contend"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/robodhop.log

echo -e "\e[33mstarting nginx server\e[0m"
systemctl enable nginx &>>/tmp/robodhop.log
systemctl restart nginx &>>/tmp/robodhop.log