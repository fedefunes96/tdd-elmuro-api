# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/xenial64'

  config.vm.network 'forwarded_port', guest: 3000, host: 3000
  config.vm.hostname = 'telegram'
  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
    vb.name = 'telegram'
  end

  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y build-essential git

    sudo apt-get install -y postgresql-9.5 postgresql-contrib postgresql-server-dev-9.5
    sudo -u postgres psql --dbname=postgres -f /vagrant/create_dev_and_test_dbs.sql

    sudo apt-get install libpq-dev

    sudo apt-get install -y gnupg2
    gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    rvm install 2.5.1
    rvm use 2.5.1
    rvm gemset create telegram
    rvm gemset use telegram
    gem install bundler -v '1.17.3'
  SHELL
end
