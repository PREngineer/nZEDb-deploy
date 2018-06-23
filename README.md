# Please Support This Project!

This project is being developed during my spare time.  I find it to be very useful for people that are starting to use nZEDb and have little to no previous experience with Ubuntu/Debian Servers.  I would appreciate a donation if you found it useful.

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=53CD2WNX3698E&lc=US&item_name=PREngineer&item_number=nZEDb%2ddeploy&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)

You can also support me by sending a BitCoin donation to the following address:

19JXFGfRUV4NedS5tBGfJhkfRrN2EQtxVo

# nZEDb Tested/Recommended Configuration

These scripts can be used to deploy nZEDb to a Virtual Machine or Hard Machine with the following specs:

* Operating System: Ubuntu 14.04 LTS 64-bit [Other Ubuntu/Debian possibly works but not tested]
* CPU: 4
* RAM: 8 GB

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

# TO DOs (After installing)

* To enable Memcache:
```
cp /var/www/nzedb/nzedb/config/settings.example.php  /var/www/nzedb/nzedb/config/settings.php
sudo nano /var/www/nzedb/nzedb/config/settings.php
```
Change the Cache Type to:

> define('nZEDb_CACHE_TYPE', 1);
