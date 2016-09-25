execute 'mongodb-org install' do
  command <<-EOL
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
    echo 'deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main' | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org=3.2.9 mongodb-org-server=3.2.9 mongodb-org-shell=3.2.9 mongodb-org-mongos=3.2.9 mongodb-org-tools=3.2.9
    echo 'mongodb-org hold' | sudo dpkg --set-selections
    echo 'mongodb-org-server hold' | sudo dpkg --set-selections
    echo 'mongodb-org-shell hold' | sudo dpkg --set-selections
    echo 'mongodb-org-mongos hold' | sudo dpkg --set-selections
    echo 'mongodb-org-tools hold' | sudo dpkg --set-selections
  EOL
end

remote_file '/etc/mongod.conf' do
  owner 'root'
  group 'root'
  mode '0644'
end

remote_file '/etc/init.d/disable-transparent-hugepages' do
  owner 'root'
  group 'root'
  mode '0755'
end

execute 'sudo update-rc.d disable-transparent-hugepages defaults'

service 'mongod' do
  action %i(enable start)
end
