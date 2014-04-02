zabbix_1000k Cookbook
=====================

Requirements
------------
- [opscode-cookbooks/yum](https://github.com/opscode-cookbooks/yum)

Attributes
----------
- `default['zabbix_1000k']['zabbix_server_mysql_version']`: this value should match with the result of `zabbix-server-mysql -V` command.

Usage
-----
### zabbix_1000k::default
Setup repositories and installs zabbix-agent.

### zabbix_1000k::agent
Installs zabbix-agent.

### zabbix_1000k::server
Installs zabbix-server and related components.


Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
The MIT License (MIT)

Author: SENDA Keijiro
