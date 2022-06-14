set :rails_env, 'production'
set :pty, true
set :branch, 'bolorshop'
server '174.138.23.91', user: 'deploy', roles: %w{app db web}
