# frozen_string_literal: true
node.reverse_merge!(YAML.load_file("#{File.dirname(__FILE__)}/../nodes/default.yml"))
rbenv_hash = YAML.load_file("#{File.dirname(__FILE__)}/../nodes/rbenv.yml")
node.reverse_merge!(rbenv_hash)
include_recipe '../cookbooks/initialize/default.rb'
include_recipe '../cookbooks/rbenv/default.rb'
include_recipe '../cookbooks/nodejs/default.rb'
include_recipe '../cookbooks/java/default.rb'

nginx_hash = YAML.load_file("#{File.dirname(__FILE__)}/../nodes/nginx_build.yml")
node.reverse_merge!(nginx_hash)
include_recipe '../cookbooks/nginx/default.rb'

local_hash = YAML.load_file("#{File.dirname(__FILE__)}/../nodes/local.yml")
node.reverse_merge!(local_hash)
include_recipe '../cookbooks/app/default.rb'
