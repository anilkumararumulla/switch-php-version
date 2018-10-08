#!/bin/bash

switch_version()
{
    echo "Switching to PHP"$version
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
    while true; do
        read -p "PHP$version is not installed `echo '\n '`Would like to install this PHP$version [Y/n] ?" answer
        answer=${answer:-yes}
        case $answer in
            [Yy]* ) make install; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    sudo apt update
    sudo apt install tree
}

read -p "Please enter the version to switch (Ex. 5.6): `echo '\n> '`" version

dpkg -s $version 2> /dev/null

if [ $? -eq 0 ]; then
    switch_version
else
    install_version
    switch_version
fi