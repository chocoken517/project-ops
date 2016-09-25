%w(git gcc libssl-dev).each do |pkg|
  package pkg
end

execute 'groupadd nginx' do
  not_if 'cat /etc/group | grep nginx'
end

execute 'useradd -g nginx nginx' do
  not_if 'cat /etc/passwd | grep nginx'
end

include_recipe 'nginx_build'
include_recipe 'nginx_build::install'

['/var/log/nginx', "/var/log/nginx/#{node[:project][:server_name]}"].each do |dir|
  directory dir do
    owner 'nginx'
    group 'nginx'
    mode '0755'
  end
end

template node[:nginx_build][:nginx_conf] do
  source 'templates/etc/nginx/nginx.conf.erb'
  variables({
    nginx_user: node[:nginx_build][:nginx_user],
    nginx_pid: node[:nginx_build][:nginx_pid]
  })
  owner 'root'
  group 'root'
  mode '0644'
end

%w(/etc/nginx/site-available /etc/nginx/site-enabled).each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
  end
end

template "/etc/nginx/site-available/#{node[:project][:name]}.conf" do
  source "templates/etc/nginx/site-available/#{node[:project][:name]}.conf.erb"
  variables(
              {
                project_directory: node[:project][:directory],
                server_name: node[:project][:server_name]
              }
  )
  owner 'root'
  group 'root'
  mode '0644'
end

link "/etc/nginx/site-enabled/#{node[:project][:name]}.conf" do
  to "/etc/nginx/site-available/#{node[:project][:name]}.conf"
end

service 'nginx' do
  action %i(enable start)
end
