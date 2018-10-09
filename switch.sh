#!/bin/bash

switch_version()
{
    echo "Switching to PHP"$version
    sudo apt install php$version-dev
    sudo a2dismod php*
    sudo a2enmod php$version
    sudo service apache2 restart

    sudo update-alternatives --set php /usr/bin/php$version
    sudo update-alternatives --set phar /usr/bin/phar$version
    sudo update-alternatives --set phar.phar /usr/bin/phar.phar$version
    sudo update-alternatives --set phpize /usr/bin/phpize$version
    sudo update-alternatives --set php-config /usr/bin/php-config$version
}

install_version()
{
    # while true; do
        read -p "PHP$version is not installed `echo '\n '`Would like to install this PHP$version [Y/n] ?" answer
        answer=${answer:-yes}
        case $answer in
            [Yy]* ) sudo add-apt-repository ppa:ondrej/php; sudo apt update; sudo apt install php$version; sudo apt install php$version-dev break;;
            [Nn]* ) exit;;
            * ) echo "In Valid Entry. Abort"; exit;;
        esac
    # done
}

read -p "Please enter the version to switch (Ex. 5.6): `echo '\n> '`" version

dpkg -s php$version 2> /dev/null

if [ $? -eq 0 ]; then
    switch_version
else
    install_version
    switch_version
fi