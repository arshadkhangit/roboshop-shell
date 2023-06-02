source common.sh
echo -e "{$color} installing nginx server {$nocolor}"
yum install nginx -y &>>$log_file
stat_check

echo -e "{$color}removing old app content{$nocolor}"
rm -rf /usr/share/nginx/html/* &>>$log_file
stat_check
echo -e "{$color}downloading frontend content{$nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
stat_check
echo -e "{$color}extraacting frontend contend{$nocolor}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$log_file
stat_check
echo -e "{$color} Copy roboshop.conf {$nocolor}"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log
stat_check
echo -e "{$color}starting nginx server {$nocolor}"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
stat_check