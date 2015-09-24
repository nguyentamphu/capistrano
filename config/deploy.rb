# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'capistrano'
set :repo_url, 'git@github.com:nguyentamphu/capistrano.git'
set :deploy_to, '/home/ntp/capistrano'
set :deploy_user, 'ntp'
set :password: '123'
# set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets}
set :branch, 'develop'

namespace :deploy do
  desc 'Invoke a rake command'
  task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
    on primary(:app) do
      within current_path do
        with :rails_env => fetch(:rails_env) do
          rake args[:command]
        end
      end
    end
  end
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
