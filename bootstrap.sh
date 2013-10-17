#!/usr/bin/env bash

sudo su

pm="apt-get"

echo -e "\nUsing $pm for package installation\n"

# Install build tools
echo -e "\n=> Installing build tools..."
sudo $pm -y install \
    wget curl build-essential clang \
    bison openssl zlib1g \
    libxslt1.1 libssl-dev libxslt1-dev \
    libxml2 libffi-dev libyaml-dev \
    libxslt-dev autoconf libc6-dev \
    libreadline6-dev zlib1g-dev libcurl4-openssl-dev \
    libtool
echo "==> done..."

echo -e "\n=> Installing libs needed for sqlite and mysql..."
sudo $pm -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient-dev
echo "==> done..."

echo -e "\n=> Installing nodejs..."
sudo $pm -y install nodejs
echo "==> done..."

# Install git-core
echo -e "\n=> Installing git..."
sudo $pm -y install git-core
echo "==> done..."

echo -e "\n=> Downloading Ruby $ruby_version_string \n"
wget http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
echo -e "\n==> done..."
echo -e "\n=> Extracting Ruby $ruby_version_string"
tar -xzvf ruby-2.0.0-p247.tar.gz
cd ruby-2.0.0-p247/
echo "==> done..."
echo -e "\n=> Building Ruby $ruby_version_string (this will take a while)..."
./configure --prefix=/usr/local
make
make install
echo "==> done..."

echo -e "\n=> Updating Rubygems..."
gem update --system --no-ri --no-rdoc
echo "==> done..."

echo -e "\n=> Installing bundler and rails..."
gem install bundler rails --no-ri --no-rdoc -f 
echo "==> done..."

echo -e "\n=> Fix nokogiri warning with libxml2..."
gem pristine nokogiri
echo "==> done..."

echo    "### Installation is complete! Enjoy! ###"