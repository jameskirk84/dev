# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

config_file = ENV["config"] || './config.json'

if not File.exists? config_file
  abort "ERROR: Missing configuration file: #{config_file}"
end

setup = JSON.load(IO.read(config_file));

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |v|
    v.name = "dev-env2"
    v.memory = 1024
    v.cpus = 2
  end

  if setup.has_key? 'synced_folders'
    setup["synced_folders"].each do |sync|
      config.vm.synced_folder sync["src"], sync["dest"]
    end
  end

  config.vm.hostname = "dev-env2"
  config.vm.provision "shell", path: "bootstrap.sh"
end
