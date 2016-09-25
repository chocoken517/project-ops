remote_file '/etc/apt/sources.list' do
  owner 'root'
  group 'root'
end

execute 'apt-get update' do
  command 'apt-get update -y'
end

%w(ntp less vim).each do |pkg|
  package pkg
end

execute 'cp -pf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime'
service 'ntp' do
  action %i(enable start)
end
execute 'sudo hwclock --systohc --localtime'
