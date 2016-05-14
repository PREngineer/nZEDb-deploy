#!/bin/bash
# Script Name: nZEDb Setup - Part 1
# Author: PREngineer - pianistapr@hotmail.com
# License: Personal Use (1 device)
# IMPORTANT: RUN THIS SCRIPT FIRST!
# This Script contains the Pre-requisites
# Before the first reboot.
#############################################

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
echo -e "┌─┐┌┬┐┌─┐┬─┐┌┬┐┌─┐┬─┐"
echo -e "└─┐ │ ├─┤├┬┘ │ ├┤ ├┬┘"
echo -e "└─┘ ┴ ┴ ┴┴└─ ┴ └─┘┴└─"

echo -e $CYAN
echo -e "Brought to you by PREngineer"
echo
echo -e $GREEN'nZEDb Server Setup - Part 1'$BLACK
echo 

echo -e $RED'1. This script has been tested on Ubuntu (Server & Desktop).'
echo -e '2. The author(s) cannot be held accountable for any problems that might occur if you run this script.'
echo -e '3. Proceed only if you authorize this script to make changes to your system.'$BLACK
echo

echo -e $YELLOW
echo -e "---> [Starting ZNC...]"$BLACK
znc -r
echo -e $GREEN
echo -e "DONE!"

echo -e $YELLOW
echo -e "---> [Starting TMUX...]"$BLACK
sudo php /var/www/nzedb/misc/update/nix/tmux/start.php
echo -e $GREEN
echo -e "DONE!"