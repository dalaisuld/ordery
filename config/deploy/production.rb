set :rails_env, 'production'
set :pty, true

server '139.59.247.112', user: 'deploy', roles: %w{app db web}
