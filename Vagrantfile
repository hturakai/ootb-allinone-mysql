# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    #vb.customize ["modifyvm", :id, "--cpus", "2"]   
  end  

  #config.vm.share_folder('templates', '/tmp/vagrant-puppet/templates', 'templates')

  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
    #puppet.options = ["--templatedir","/tmp/vagrant-puppet/templates", "--verbose", "--debug"]
    puppet.options = ["--verbose", "--debug"]
  end
  config.vm.box = "trusty64"

  config.vm.network "forwarded_port", guest: 8080, host: 3080

end
