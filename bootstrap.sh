#!/usr/bin/env bash

# Functions
function printMessage() {
	echo -e "\n=> $1 \n"
}

function printDone() {
	echo "==> done..."
}

function dos2unix(){
  tr -d '\r' < "$1" > t
  mv -f t "$1"
}

function unix2dos(){
  sed -i 's/$/\r/' "$1"
}
#========================

# Var declarations
pm="sudo apt install -y"
#========================

# Installing essential tools
printMessage "Installing essential tools"
$pm wget curl build-essential clang
$pm bison openssl zlib1g make gcc pkg-config autoconf
$pm libxslt1.1 libssl1.0-dev libxslt1-dev install tcl8.5
$pm libxml2 libffi-dev libyaml- libxslt-dev libc6-dev
$pm libreadline6-dev libgdbm-dev zlib1g-dev libcurl4-openssl-dev libtool
$pm libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient-dev libpq-dev
$pm git-core software-properties-common python-software-properties
$pm docker.io
printDone
#========================

# Repos install
printMessage "Installing essential repos"
sudo add-apt-repository ppa:ondrej/php
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get update
printDone
#========================

# Nodejs install
printMessage "Installing NodeJS"
$pm nodejs
printDone
#========================

# MySQL install
printMessage "Installing MariaDB 10"
$pm mariadb-server mariadb-client
printDone
#========================

# Redis Install
printMessage "Installing Redis"
$pm redis-server
printDone
#========================

# Ruby install
printMessage "Installing Ruby"
$pm ruby-full
printDone
#========================

# Ruby on Rails install
printMessage "Installing Rails"
sudo gem update --system
sudo gem install bundler
sudo gem install rails
printDone
#========================

# PHP install
printMessage "Installing PHP"
sudo $pm php7.3 php7.3-common php7.3-dev php7.3-mbstring php7.3-cli php7.3-curl php7.3-gd php7.3-mysql php7.3-sqlite3
printDone
#========================

# Composer install
printMessage "Installing Composer"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
printDone
#========================

# Bash install
printMessage "Installing bash"
git clone https://github.com/gregperes/bash.git /home/vagrant/.bash
dos2unix /home/vagrant/.bash/**/*.sh
echo 'source /home/vagrant/.bash/init.sh' >> /home/vagrant/.bash_profile
printMessage "All done. Enjoy! ;)"
#========================