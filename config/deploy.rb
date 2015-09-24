# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'capistrano'
set :repo_url, 'git@github.com:nguyentamphu/capistrano.git'
set :deploy_to, '/home/ntp/capistrano'
set :user, 'ntp'
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets}

namespace :deploy do

  %w[start stop restart].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 1 do
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  after :publishing, :restart

end