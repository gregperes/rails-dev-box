#!/usr/bin/env bash

sudo su

apt-get update && sudo apt-get upgrade

apt-get install -y git curl vim make
apt-get install -y build-essential zlib1g-dev curl git-core sqlite3 libsqlite3-dev
apt-get install -y sqlite3 libsqlite3-dev nodejs

wget http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar -xzvf ruby-2.0.0-p247.tar.gz
cd ruby-2.0.0-p247/
./configure
make
make install

gem update --system
gem install rails
gem install sqlite3
gem install execjs

source ~/.profile
