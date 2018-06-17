# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "pequod_base.box"
  # config.vm.box_url = "http://tiny.si/pequod_base.box"
  config.vm.define "pequod", primary: true do |pequod|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    config.ssh.username = "ahab"
    config.vm.provider :virtualbox do |vb|
      vb.name = "pequod"
    end
  
    config.vm.provision "shell", inline: "echo Call me Ishmael."
    config.vm.provision "shell", path: "provisions/install/docker.sh"
    # config.vm.provision "shell", path: "provisions/install/docker_containers.sh"
    config.vm.provision "shell", inline: "echo Thus, I give up the spear!"
  end
end
