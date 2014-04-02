include_recipe 'zabbix_1000k::default'

package 'zabbix-agent'

service 'zabbix-agent' do
  action [:enable, :start]
end