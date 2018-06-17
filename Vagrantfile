# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'getoptlong'

opts = GetoptLong.new(
  [ '--box_path', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--box_url', GetoptLong::REQUIRED_ARGUMENT ])

local_box = false
box_path = "professionallyevil/pequod"
box_url = "http://tiny.si/pequod_base.box"

opts.each do |opt, arg|
  case opt
    when '--box_path'
      if arg == ''
        abort
      end
      box_path = arg
      local_box = true
    when '--box_url'
      if arg == ''
        abort
      end
      box_url = arg
  end
end

Vagrant.configure("2") do |config|
  
  config.vm.box_url = box_url 
  # default to using tiny.si url
  config.vm.box = box_path 
  
  #config.vm.box = "pequod_base.box"
  # config.vm.box_url = "http://tiny.si/pequod_base.box"
  config.vm.define "pequod", primary: true do |pequod|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    config.ssh.username = "ahab"
    config.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "pequod"
    end
  
    config.vm.provision "shell", inline: "echo Call me Ishmael."
    config.vm.provision "shell", path: "provisions/install/docker.sh"
    # config.vm.provision "shell", path: "provisions/install/docker_containers.sh"
    config.vm.provision "shell", inline: "echo Thus, I give up the spear!"
  end
end
