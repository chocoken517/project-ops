# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'project'
set :repo_url, 'git@github.com:xxxxxxx/xxxxxxxx.git'
set :scm, :git
set :deploy_to, '/path/to/project/app'
set :log_level, :debug
set :format, :airbrussh
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto
set :pty, true
append :linked_files, 'config/settings.local.yml'
append :linked_dirs, 'config/puma', 'log', 'tmp/sockets', 'tmp/pids', 'vendor/bundle', 'public/system'
set :default_env, path: '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH', JAVA_HOME: '/usr/lib/jvm/java-8-openjdk-amd64'
set :keep_releases, 5
set :keep_assets, 5
set :rbenv_type, :system
set :rbenv_ruby, File.read('.ruby-version').strip
set :puma_conf, '/path/to/project/app/shared/config/puma.rb'

namespace :deploy do
  task :restart do
    invoke 'puma:restart'
  end
end
