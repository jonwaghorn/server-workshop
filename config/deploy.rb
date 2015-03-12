# config valid only for Capistrano 3.1
lock '3.2.1'

set :ssh_options, {
  forward_agent: true
}

set :application, 'workshop'
set :repo_url, 'git@github.com:jonwaghorn/server-workshop.git'

set :deploy_to, '/home/deploy/workshop'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end