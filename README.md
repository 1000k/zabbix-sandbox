Zabbix on Vagrant sandbox
=========================

Requirements
------------
- Git
- [Vagrant >= 1.3](http://www.vagrantup.com/downloads.html)
- (option) [vagrant-proxyconf](https://github.com/tmatilai/vagrant-proxyconf)

Usage
-----
### Configure Vagrantfile
1. `git submodule init`
1. `mv Vagrantfile.sample Vagrantfile`
1. (option: if you use proxy) Install 'vagrant-proxyconf' plugin via `$ vagrant plugin install vagrant-proxyconf`.
1. Fill the configurations in 'Vagrantfile'.
  - Vagrant box should be RHEL or CentOS.
1. Type `vagrant up`.
1. `zabbixserver` and `zabbixnode` VM will be created.

### Setup Zabbix Server
1. Access to `http://localhost:8080/zabbix/`. (default)
  - If you changed `forwarded_port` in Vagrantfile, change port from 8080.
1. Click 'Next' several times.
1. Login control panel.
  - Login name: `admin`
  - Password: `zabbix`

### Add Node to Server
1. Edit server ip address in `/etc/zabbix/zabbix_agentd.conf` on zabbix node server.
1. Register the node via Zabbix Server web-interface.
  - Detailed instruction: [Installing the Zabbix Agent on a Linux Server [Zabbix]](https://www.zabbix.com/wiki/howto/monitor/os/linux/agentinstallonlinux)

Troubleshooting
---------------
If the version of Zabbix-Server-MySQL is changed, edit the value of `default['zabbix_1000k']['zabbix_server_mysql_version']` in `site-cookbooks/zabbix_1000k/attributes/default.rb`.