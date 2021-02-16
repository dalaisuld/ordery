set :rails_env, 'production'
set :pty, true
set :branch, 'etoys'
server '188.166.185.184', user: 'deploy', roles: %w{app db web}
