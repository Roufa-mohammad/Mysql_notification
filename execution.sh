#===============================================================================
#********************************project****************************************
#*****************mysql update to linux notification****************************
#team members:jahnavi,Purnasai,Vijayalakshmi,Uttejsai,Venkat,Reshma,Gopikumar***
#===============================================================================
#!/bin/sh
#cd

######giving root to mysqlvariable##############################################
MYSQL_USER="root" 

######giving password to mysqlvariable##########################################
MYSQL_PASSWORD="33652210035869" 

######database creation and using###############################################
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD  -e  "DROP database IF EXISTS spp ;create database spp;use spp;"

######giving database to mysqlvariable##########################################
DBNAME="spp"

######table creation,inserting values to mysql table############################
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -D$DBNAME -e  "DROP TABLE IF EXISTS dob;CREATE TABLE dob(name varchar(30),date varchar(30));LOAD DATA LOCAL INFILE '/home/personal/Desktop/mysqlupdatenotification/inputdata' INTO TABLE dob FIELDS TERMINATED BY ' ';DROP TABLE IF EXISTS dob1;CREATE TABLE dob1(name varchar(30),date varchar(30));"

######creating procedure in file and dumping into mysql#########################
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -D$DBNAME < /home/personal/Desktop/mysqlupdatenotification/myproce.sql

######calling procedure and sending procedure output to text file###############
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -D$DBNAME -e"drop table dob1 ;CREATE TABLE dob1 (name varchar(30) , day varchar(30));call day();select * from dob1"  > /home/personal/Desktop/mysqlupdatenotification/t.txt


###### awk command to give unique data by avoiding duplicate data###############
awk '!seen[$0]++' /home/personal/Desktop/mysqlupdatenotification/t.txt > /home/personal/Desktop/mysqlupdatenotification/j.txt

###### awk command to print the data between // ################################
awk '$0 ~ /IS CELEBRATING BIRTHDAY TODAY/{print}' /home/personal/Desktop/mysqlupdatenotification/j.txt > /home/personal/Desktop/mysqlupdatenotification/k.txt


######creating notification with final output###################################

notify-send  -i /home/personal/Desktop/mysqlupdatenotification/cake.ico "   hey HI, BIRTHDAY NOTIFICATION"  "`tail /home/personal/Desktop/mysqlupdatenotification/k.txt`" -t 10000

 ######creating dailouge with final output#######################################
 dialog --title "WISH HAPPY BIRTHDAY To YOUR BEST" --textbox /home/personal/Desktop/mysqlupdatenotification/k.txt 10 80


