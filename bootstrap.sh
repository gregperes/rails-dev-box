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
pm="apt-get install -y"
#========================

# apt-get updating
printMessage "apt-get updating..."

sudo apt-get update
sudo apt-get upgrade

printDone
#========================

# Installing essential tools
printMessage "Installing essential tools"

sudo $pm wget curl build-essential clang
sudo $pm bison openssl zlib1g
sudo $pm libxslt1.1 libssl-dev libxslt1-dev install tcl8.5
sudo $pm libxml2 libffi-dev libyaml-dev
sudo $pm libxslt-dev autoconf libc6-dev
sudo $pm libreadline6-dev zlib1g-dev libcurl4-openssl-dev libtool
sudo $pm libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient-dev
sudo $pm git-core python-software-properties libpq-dev

printDone
#========================

# Nodejs install
printMessage "Installing NodeJS"

curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo $pm nodejs

printDone
#========================

# MySQL install
printMessage "Installing MySQL"

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

printDone
#========================

# Redis Install
printMessage "Installing Redis"

wget http://download.redis.io/releases/redis-3.0.2.tar.gz
tar xzf redis-3.0.2.tar.gz
rm redis-3.0.2.tar.gz
sudo mv redis-3.0.2 /etc/redis

cd /etc/redis
make

echo -n | sudo utils/install_server.sh

printDone
#========================

# Ruby on Rails install
printMessage "Installing Ruby"

wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
echo -e "\n==> done..."
echo -e "\n=> Extracting Ruby 2.2.2"
tar -xzvf ruby-2.2.2.tar.gz
cd ruby-2.2.2

./configure --prefix=/usr/local
make
make install

cd ..
rm -R ruby-2.2.2
rm ruby-2.2.2.tar.gz

sudo gem update --system --no-ri --no-rdoc

printMessage "Installing Rails"

sudo gem install bundler --no-rdoc --no-ri
sudo gem install rails --no-rdoc --no-ri
sudo gem install nokogiri --no-rdoc --no-ri
sudo gem pristine nokogiri

printDone
#========================

# PHP install
printMessage "Installing PHP"

sudo $pm php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql php5-sqlite
sudo $pm php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

sudo a2enmod rewrite

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

sudo service apache2 restart

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

printDone
#========================

printMessage "Installing bash"

git clone https://github.com/gregperes/bash.git /home/vagrant/.bash
dos2unix /home/vagrant/.bash/**/*.sh
echo 'source /home/vagrant/.bash/init.sh' >> /home/vagrant/.bash_profile

printMessage "All done. Enjoy! ;)"
#========================