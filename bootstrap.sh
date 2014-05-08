#!/usr/bin/env bash

function printMessage() {
	echo -e "\n=> $1 \n"
}

function printDone() {
	echo "==> done..."
}

# Nodejs PPA
sudo add-apt-repository ppa:chris-lea/node.js 

# apt-get updating
printMessage "apt-get updating..."

sudo apt-get update
sudo apt-get upgrade

printDone

# Var declarations
pm="apt-get install -y"

# Installing essential tools
printMessage "Installing essential tools"

sudo $pm wget curl build-essential clang
sudo $pm bison openssl zlib1g
sudo $pm libxslt1.1 libssl-dev libxslt1-dev
sudo $pm libxml2 libffi-dev libyaml-dev
sudo $pm libxslt-dev autoconf libc6-dev
sudo $pm libreadline6-dev zlib1g-dev libcurl4-openssl-dev libtool
sudo $pm libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient-dev
sudo $pm git-core nodejs python-software-properties libpq-dev

sudo apt-get update

printDone

# MySQL install
printMessage "Installing MySQL"

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

printDone

# Ruby on Rails install
printMessage "Installing Ruby"

wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz
echo -e "\n==> done..."
echo -e "\n=> Extracting Ruby 2.1.1"
tar -xzvf ruby-2.1.1.tar.gz
cd ruby-2.1.1

./configure --prefix=/usr/local
make
make install
cd ..
rm -R ruby-2.1.1
rm -R ruby-2.1.1.tar.gz

su vagrant

gem update --system --no-ri --no-rdoc

printMessage "Installing Rails"

gem install bundler --no-rdoc --no-ri
gem install rails --no-rdoc --no-ri
gem install nokogiri --no-rdoc --no-ri
gem pristine nokogiri

printDone

# PHP install
printMessage "Installing PHP"

sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update

sudo $pm php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql
sudo $pm php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
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

# Bash scripts install
dos2unix(){
  tr -d '\r' < "$1" > t
  mv -f t "$1"
}

unix2dos(){
  sed -i 's/$/\r/' "$1"
}

printMessage "Installing bash"

git clone https://github.com/gregperes/bash.git /home/vagrant/.bash
dos2unix /home/vagrant/.bash/**/*.sh
echo 'source /home/vagrant/.bash/init.sh' >> /home/vagrant/.bash_profile

printMessage "All done. Enjoy! ;)"
