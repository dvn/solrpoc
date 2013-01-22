# http://vagrantup.com/v1/docs/vagrantfile.html
# # vi:ft=ruby:

Vagrant::Config.run do |config|
  config.vm.box = "centos"
  config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"

  config.vm.forward_port 8983, 8983

  config.vm.customize ["modifyvm", :id, "--name", "solrpoc", "--memory", 1024]

  config.vm.share_folder "solr-tarball", "/solr-tarball", "solr-tarball"
  config.vm.share_folder "solr-perl", "/solr-perl", "perl"
  config.vm.share_folder "solr-data", "/solr-data", "data"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file  = "init.pp"
  end
end
