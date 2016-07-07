# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 5432, host: 5432
 
  config.vm.provision :shell, path: "bootstrap.sh"

end
