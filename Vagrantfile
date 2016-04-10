Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/wily64"
  config.vm.synced_folder "../second-memory-client/", "/var/www/sm/", mount_options: ["dmode=777", "fmode=666"]
  config.vm.synced_folder "../second-memory-server/", "/var/www/sms/", mount_options: ["dmode=777", "fmode=666"]
  config.vm.synced_folder "sites-enabled/", "/etc/apache2/sites-enabled/"
  config.vm.network :forwarded_port, guest: 81, host: 8081
  config.vm.network :forwarded_port, guest: 82, host: 8082
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.provision :shell, :inline => "service apache2 restart", run: "always"
end
