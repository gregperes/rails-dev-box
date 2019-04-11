VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "wboxdev"
  #config.vm.provision :shell, :inline => "apt-get -y update; apt-get -y install puppet"
  #config.vm.provision :puppet
  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.provider "virtualbox" do |v|
    v.name = "wboxdev"
    v.memory = 2048
    v.cpus = 2
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  config.vm.network :forwarded_port, guest: 3000,  host: 3000    # rails
  config.vm.network :forwarded_port, guest: 9292,  host: 9292    # rack
  config.vm.network :forwarded_port, guest: 4567,  host: 4567    # sinatra
  config.vm.network :forwarded_port, guest: 1080,  host: 1080    # mailcatcher
  config.vm.network :forwarded_port, guest: 8888,  host: 8888    # jasmine
  config.vm.network :forwarded_port, guest: 3306,  host: 3306    # mysql
  config.vm.network :forwarded_port, guest: 5432,  host: 5432    # postgresql
  config.vm.network :forwarded_port, guest: 6379,  host: 6379    # redis
  config.vm.network :forwarded_port, guest: 27017, host: 27017   # mongodb
  config.vm.network :forwarded_port, guest: 8000,  host: 8000    # node
  config.vm.network :forwarded_port, guest: 8080,  host: 8080    # java
  config.vm.network :forwarded_port, guest: 80,    host: 8090    # apache/nginx
end