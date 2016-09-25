set :rails_env, 'production'
set :branch, 'master'

server  '111.111.111.xxx',
        user: 'app',
        roles: %i(app web),
        ssh_options: {
          forward_agent: true,
          auth_methods: %w(publickey)
        }
