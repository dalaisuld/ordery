set :rails_env, 'production'
set :pty, true
set :branch, 'bigmall'
server '159.89.197.33', user: 'deploy', roles: %w{app db web}
