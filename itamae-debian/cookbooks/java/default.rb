package 'openjdk-8-jdk'

file 'bash.bashrc add java-8-openjdk-amd64'do
  action :edit
  path '/etc/bash.bashrc'
  block { |content| content << "\nexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" }
  not_if 'grep JAVA_HOME /etc/bash.bashrc'
end
