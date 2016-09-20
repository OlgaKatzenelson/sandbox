#!/bin/bash
#This script is for installation of spark slave on a linux - ubuntu
#It updates system install utils, jdk 8 and spark 2.0

cd ~/
echo "Utilities for linux:"

sudo apt-get clean
sudo apt-get update -y
sudo apt-get install rpm -y
sudo apt-get install ufw -y
sudo apt-get install curl -y
sudo apt-get install wget -y
#make sure linux is running jdk8 and all env are set...

echo "Installing java"

curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.rpm > jdk-8u102-linux-x64.rpm
rpm -Uvh jdk-8u102-linux-x64.rpm
# If fails install from ther repo
sudo apt-cache search jdk
#choose openjdk-8-jdk
sudo apt-get install openjdk-8-jdk -y


wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz
tar -zxvf spark-2.0.0-bin-hadoop2.7.tgz
mv spark-2.0.0-bin-hadoop2.7 spark
export SPARK_HOME=$(pwd)/spark
export PATH=$SPARK_HOME/bin:$PATH
#for example
export MASTER_IP=192.168.179.160
#Add system env to you shell 
echo 'export SPARK_HOME=$(pwd)/spark'>>.bashrc
echo 'export PATH=$SPARK_HOME/bin:$PATH'>>.bashrc

#Here you need to allow your firewall all inner network connections
#use ufw for iptables managment
sudo iptables -F
sudo ufw status numbered
sudo ufw enable
sudo ufw status numbered
sudo ufw allow 22
# allow access from you subnet, substitude this example ip with real
# don't forget to allow local it on the master machine to allow it managing and accessing the slave

# for example this one allows all subnetwork of kind 192.168.0.0 - 192.168.255.255
sudo ufw allow from 192.168.0.0/16 to any

# if you want to be more strict do for each specific ip tha you want to include in the network
sudo ufw allow from "ip master" to any
sudo ufw allow from "ip slave 1" to any

sudo ufw allow 80
sudo ufw allow 443

#Allow connections to a specific network interface
#sudo ufw allow in on eth1


















