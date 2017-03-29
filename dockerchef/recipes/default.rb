#
# Cookbook:: dockerchef
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
docker_service 'default' do
  host [ "tcp://#{node['ipaddress']}:2375", 'unix:///var/run/docker.sock' ]
  action [:create, :start]
end
