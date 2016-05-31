#!/bin/bash
# Script 	Name: nZEDb Setup - Part 3
# Author: 	Jorge Pabon - PREngineer - pianistapr@hotmail.com
# License: 	Personal Use (1 device)
# IMPORTANT: RUN THIS SCRIPT LAST!
# ONLY AFTER SETTING UP NZEDB THROUGH THE 
# ADMIN WEB PORTAL:
# http://<YOURIP>/admin/
# This contains the IRCScraper and ZNC as well
# as PhpMyAdmin among other things.
###############################################

# Color definition variables
YELLOW='\e[33;3m'
RED='\e[91m'
BLACK='\033[0m'
CYAN='\e[96m'
GREEN='\e[92m'

# Make sure to clear the Terminal
clear

# Display the Title Information
echo 
echo -e $RED
echo -e "         nZEDb"
echo -e "╦╔╗╔╔═╗╔╦╗╔═╗╦  ╦  ╔═╗╦═╗"
echo -e "║║║║╚═╗ ║ ╠═╣║  ║  ║╣ ╠╦╝"
echo -e "╩╝╚╝╚═╝ ╩ ╩ ╩╩═╝╩═╝╚═╝╩╚═"

echo -e $CYAN
echo -e "Brought to you by PREngineer"
echo
echo -e $GREEN'nZEDb Server Setup - Part 3'$BLACK
echo 

echo -e $RED'1. This script has been tested on Ubuntu (Server & Desktop).'
echo -e '2. The author(s) cannot be held accountable for any problems that might occur if you run this script.'
echo -e '3. Proceed only if you authorize this script to make changes to your system.'$BLACK
echo

echo -e $YELLOW
echo -e "---> [Importing Initial PreDB Dump...]"$BLACK
sudo wget https://www.dropbox.com/s/qkmgbvmdv9a5w8q/predb_dump_08172015.tar.gz
sudo gunzip predb_dump_08172015.tar.gz
sudo tar -xvf predb_dump_08172015.tar
echo
echo -e $RED"PLEASE BE PATIENT!  THIS   + W I L L +   TAKE A LONG TIME!"$BLACK
echo
sudo php /var/www/nzedb/misc/testing/PreDB/dump_predb.php remote tmp/predb_dump_08172015.csv
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Importing Daily Dumps...]"$BLACK
sudo chmod 777 /var/www/nzedb/resources
sudo chown -R YOUR_USERNAME:www-data /var/www/nzedb/cli
echo
echo -e $RED"PLEASE BE PATIENT!  THIS   + M A Y +   TAKE A LONG TIME!"$BLACK
echo
sudo php /var/www/nzedb/cli/data/predb_import_daily_batch.php 0 remote true
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Install ZNC...]"$BLACK
sudo apt-get install python-software-properties -y
sudo apt-get install libssl-dev libperl-dev pkg-config build-essential -y > /dev/null
cd ~
sudo wget http://znc.in/releases/archive/znc-1.2.tar.gz
sudo tar -xvf znc-1.2.tar.gz
cd znc-1.2
./configure
sudo make
sudo make install
sudo rm -R ~/znc*
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Installing ZNC...]"$RED
echo
echo -e "You will be prompted for these settings."
echo

echo -e "-------------Server Settings------------"
echo -e "Port:         6666"
echo -e "SSL:          [ENTER]"
echo -e "IPV6:         No"
echo -e "-------------Global Modules-------------"
echo -e "Partyline:    Yes"
echo -e "webadmin:     Yes"
echo -e "Username:     Nick1"
echo -e "Password:     SOMEPASSWORD"
echo -e "Password:     SOMEPASSWORD"
echo -e "Admin:        Yes"
echo -e "Nick:         Nick1"
echo -e "Alt Nick:     Nick2"
echo -e "Ident:        [ENTER]"
echo -e "Real Name:    Nick1"
echo -e "Bind host:    [ENTER]"
echo -e "# of Lines:   100"
echo -e "clear buffer: [ENTER]"
echo -e "Chan Mode:    [ENTER]"
echo -e "-------------User Modules----------------"
echo -e "Chansaver:    Yes"
echo -e "Controlpanel: Yes"
echo -e "Perform:      Yes"
echo -e "Webadmin:     Yes"
echo -e "Setup Net:    Yes"
echo -e "Name:         synirc"
echo -e "-------------Network Modules-------------"
echo -e "Chansaver:    Yes"
echo -e "Keepnick:     Yes"
echo -e "KicjRejoin:   Yes"
echo -e "Nickserv:     Yes"
echo -e "Perform:      Yes"
echo -e "Simple_Away:  Yes"
echo -e "-----------------SERVERS-----------------"
echo -e "Server host:  toronto.on.ca.synirc.net"
echo -e "Server SSL:   no"
echo -e "Server Port:  6697"
echo -e "Server Pass:  [ENTER]"
echo -e "Init, Chann:  #nZEDbPRE"
echo
echo -e "-------------Add Servers:-------------"
echo -e "SERVER 1:     toronto.on.ca.synirc.net"
echo -e "PORT:         6697"
echo -e "PASSWORD:     [ENTER]"
echo -e "SSL:          [ENTER]"
echo -e "Another?:     Yes"
echo -e "--------------------------------------"
echo -e "SERVER 2:     monster.va.us.synirc.net"
echo -e "PORT:         6667"
echo -e "PASSWORD:     [ENTER]"
echo -e "SSL:          [ENTER]"
echo -e "Another?:     Yes"
echo -e "--------------------------------------"
echo -e "SERVER 3:     avarice.wa.us.synirc.net"
echo -e "PORT:         6697"
echo -e "PASSWORD:     [ENTER]"
echo -e "SSL:          [ENTER]"
echo -e "Another?:     [ENTER]"
echo -e "-------------CHANNELS-----------------"
echo -e "Add Channel:  Yes"
echo -e "Channel Name: #nZEDbPRE"
echo -e "Add Another:  No"
echo -e "Another Net:  No"
echo -e "Another User: No"
echo -e "----------------------------------------------"
echo
echo -e $CYAN"Launch ZNC now:  Yes"$RED
echo
echo -e "###########################################################"
echo -e "#I SUGGEST YOU COPY THIS INFORMATION IN YOUR NOTEPAD! E^.^3"
echo -e "###########################################################"
echo -e ""$BLACK
read -p "Press [Enter] to continue..."
znc --makeconf
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Running ZNC on startup...]"$BLACK
(crontab -l 2>/dev/null; echo "@reboot /bin/sleep 10; /usr/local/bin/znc >/dev/null 2>&1") | crontab -
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Setting Up IRC Scraper...]"$BLACK
echo -e "Fill the next blank screen with:"
echo -e "--------------------------------------"
echo -e "username          = NICK1"
echo -e "SCRAPE_IRC_SERVER = 127.0.0.1"
echo -e "SCRAPE_IRC_PORT   = 6666"
echo -e "SCRAPE_IRC_TLS    = false"
echo -e "define('SCRAPE_IRC_PASSWORD', 'password');"
echo -e "--------------------------------------"
echo -e $RED"After this, enable IRCScraper in the Page"
echo -e "http://IP/admin/tmux-edit.php"$BLACK
echo -e "--------------------------------------"
sudo cp /var/www/nzedb/nzedb/config/ircscraper_settings_example.php /var/www/nzedb/nzedb/config/ircscraper_settings.php
sudo nano /var/www/nzedb/nzedb/config/ircscraper_settings.php
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Installing TMUX...]"$BLACK
sudo apt-get install -y tmux time python-setuptools python-pip python3-setuptools python3-pip > /dev/null
sudo easy_install cymysql pynntp socketpool
sudo pip3 install cymysql pynntp socketpool
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Configuring TMUX To Run On Startup...]"$BLACK
(crontab -l 2>/dev/null; echo "@reboot /bin/sleep 10; /usr/bin/php /var/www/nzedb/misc/update/nix/tmux/start.php") | crontab -
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Installing PHPMyAdmin...]"$BLACK
sudo apt-get install -y phpmyadmin
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Tunning MySQL...]"$BLACK
sudo apt-get install mysqltuner -y
echo -e $GREEN
echo -e "DONE!"$BLACK