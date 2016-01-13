# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "nercceh/ubuntu14.04"
  config.vm.box_check_update = false

  config.vm.provision "puppet" do |puppet|
    puppet.options = "--verbose --detailed-exitcodes"

    puppet.module_path = "modules"

    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"

    puppet.hiera_config_path = "hiera.yaml"

    # custom facts
    puppet.facter = {
      "foo" => "bar"
    }
  end


end
