# frozen_string_literal: true
user node[:project][:user] do
  action :create
  username node[:project][:user]
  password node[:project][:password]
end

directory "/home/#{node[:project][:user]}" do
  owner node[:project][:user]
  group node[:project][:user]
end

DEVELOPERS = %i(chocoken517).freeze

require 'open-uri'
authorized_keys = DEVELOPERS.map { |name| open("https://github.com/#{name}.keys").read.strip }

directory "/home/#{node[:project][:user]}/.ssh" do
  owner node[:project][:user]
  group node[:project][:user]
  mode '0700'
end

file "/home/#{node[:project][:user]}/.ssh/authorized_keys" do
  content authorized_keys.compact.join("\n")
  owner node[:project][:user]
  group node[:project][:user]
  mode '0600'
end

PROJECT_DIRECTORIES = %w(/app /app/shared /app/shared/config /app/shared/config/puma).unshift('').freeze

PROJECT_DIRECTORIES.each do |dir|
  directory "#{node[:project][:directory]}#{dir}" do
    owner node[:project][:user]
    group node[:project][:user]
    mode '0755'
  end
end

remote_file "#{node[:project][:directory]}/app/shared/config/settings.local.yml" do
  source 'files/local/settings.local.yml'
  owner node[:project][:user]
  group node[:project][:user]
  mode '0644'
end

template "#{node[:project][:directory]}/app/shared/config/puma.rb" do
  source 'templates/local/puma.rb.erb'
  variables({ project_directory: node[:project][:directory] })
  owner node[:project][:user]
  group node[:project][:user]
  mode '0644'
end
