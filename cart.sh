source common.sh
component=cart

echo -e "${color} Downloading Node repo ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>$log_file
echo -e "${color} Installing Node js${nocolor}"
yum install nodejs -y  &>>$log_file
echo -e "${color} adding user ${nocolor}"
useradd roboshop  &>>$log_file

echo -e "${color} Creating a Directory${nocolor}"
rm -rf ${app_path}  &>>$log_file
mkdir ${app_path}  &>>$log_file
echo -e "${color} Dowanloading $component file ${nocolor}"
curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>$log_file
cd ${app_path}  &>>$log_file
unzip /tmp/$component.zip  &>>$log_file

cd ${app_path}
echo -e "${color} Installing application ${nocolor}"

npm install  &>>$log_file


echo -e "${color} copy service file${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service  &>>$log_file


echo -e "${color} starting $component server ${nocolor}"
systemctl daemon-reload  &>>$log_file
systemctl enable $component  &>>$log_file
systemctl restart $component  &>>$log_file