#!/bin/bash


sudo true;

yes | bash arise build -f;

sudo rm -rf /var/www/html;
sudo cp -r arise-out /var/www/html;




