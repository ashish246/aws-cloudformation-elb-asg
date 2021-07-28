#!/bin/bash
apt-get update 
apt-get install apache2
apt-get install mysql*

echo "create database mydb" | mysql 

cat << EOF | mysql mydb
CREATE TABLE MyGuests (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
email VARCHAR(50),
reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
INSERT INTO MyGuests(1, 'bob', 'foo', 'bob.foo@gmail.com');
EOF