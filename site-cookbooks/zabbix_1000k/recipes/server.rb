include_recipe 'zabbix_1000k::default'

%W{
  mysql-server
  httpd
  php
  php-pear
  php-mbstring
  php-xml
  php-devel
  php-mysql
  php-gd
  zabbix-server
  zabbix-server-mysql
  zabbix-web-mysql
  zabbix-web-japanese
  zabbix-get
}.each do |pkg|
  package pkg
end

service 'mysqld' do
  action [:enable, :start]
end

service 'httpd' do
  supports [:restart]
  action [:enable, :start]
end

version = node['zabbix_1000k']['zabbix_server_mysql_version']

execute 'create Zabbix database' do
  command <<-EOH
    mysql -uroot -e 'DROP DATABASE IF EXISTS zabbix'
    mysql -uroot -e 'CREATE DATABASE IF NOT EXISTS zabbix'
  EOH
end

execute 'create Zabbix user on database' do
  command <<-EOH
    mysql -uroot -e 'GRANT USAGE ON *.* TO zabbix@localhost'
    mysql -uroot -e 'DROP USER zabbix'
    mysql -uroot -e 'CREATE USER zabbix'
    mysql -uroot -e 'GRANT ALL ON zabbix.* TO zabbix@localhost'
    mysql -uroot -e 'FLUSH PRIVILEGES'
  EOH
end

execute 'initialize Zabbix database' do
  command <<-EOH
    mysql -uroot zabbix < /usr/share/doc/zabbix-server-mysql-#{version}/create/schema.sql
    mysql -uroot zabbix < /usr/share/doc/zabbix-server-mysql-#{version}/create/images.sql
    mysql -uroot zabbix < /usr/share/doc/zabbix-server-mysql-#{version}/create/data.sql
  EOH
end

execute 'echo "restart httpd"' do
  notifies :restart, 'service[httpd]'
end

template '/etc/php.d/zabbix.ini' do
  source 'php.d/zabbix.ini.erb'
  notifies :restart, 'service[httpd]'
end

service 'zabbix-server' do
  action [:enable, :start]
end
