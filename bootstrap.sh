#!/usr/bin/env bash

sudo su

apt-get -y update

apt-get install -y git curl vim make
apt-get install -y sqlite3 libsqlite3-dev nodejs

curl -L https://get.rvm.io | bash -s stable
source /usr/local/rvm/scripts/rvm

rvm install 2.0
rvm use 2.0.0 --default

gem update --system
gem install rails
gem install sqlite3
gem install execjs

source ~/.profile
