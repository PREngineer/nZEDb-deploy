# nZEDb-deploy
A collection of scripts to automate and simplify the deployment of a nZEDb Usenet Indexer using the new format of their GitHub repository.

## nZEDb-1.sh

First Phase of the deployment.  Execution goes like follows:

* Install VMware Tools for Virtual Machines
* Remove AppArmor
* Install Python 3
* Update System & Upgrade Apps
* Reboot System (VERY IMPORTANT BECAUSE OF APPARMOR)

## nZEDb-2.sh

Second Phase of the deployment.  Occurs after the FIRST reboot.  Execution goes like follows:

* Install PHP & Extensions
* Install MySQL 5.6
* Create the 'nzedb' user in MySQL and grant it permission
* Install Nginx & FPM
* Configuring Nginx Virtual Server Entries
  * covers
  * admin
  * install
  * phpmyadmin
* Make sure Apache2 is removed
* Fix PHP.ini files to improve performance
* Install Media Processors
* Fix Permissions of the /var/www/nzedb folders & /var/lib/php5/sessions
* Install MemCached & APC
* Install Pzip & PAR2
* Reboot

The user  M U S T  configure the Admin portal before executing the third step.

## nZEDb-3.sh

Final Phase of the deployment.  Occurs after the SECOND reboot.  Execution goes like follows:

* Import Initial PreDB Dump into Database
* Import additional Daily Dumps into the Database
* Install PPA for ZNC
* Set up ZNC to auto-start
* Install TMUX to automate binaries search & release creation
* Set up TMUX to run on startup
* Install PHPMyAdmin
* Secure & tune MySQL

Hope it helps!

# IMPORTANT!

Inside the script you have to change the values that say:

YOUR_USERNAME  <--- Make it your Ubuntu Username

YOUR_PASSWORD  <--- Make it your selected Password
