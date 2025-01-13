#!/bin/bash


sudo true;


cp arise-source/config/arise.conf arise-source/config/arise.conf.bak;
cp -f arise-source/config/arise.conf.dev arise-source/config/arise.conf;


bash deploy.sh;

# yes | bash arise build -f;

# sudo rm -rf /var/www/html;
# sudo cp -r arise-out /var/www/html;




mv -f arise-source/config/arise.conf.bak arise-source/config/arise.conf;




