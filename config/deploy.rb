set :application, 'cloudstack-api-broker'
set :repo_url, 'git@github.com:atistler/cloudstack-api-broker.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/srv/app'
set :scm, :git
set :user, 'root'
set :format, :pretty
set :log_level, :debug
set :pty, true

set :ssh_options, {
  forward_agent: true,
  user: 'root'
}

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  task :start do
    "bundle exec thin start -C config/thin-config.yml"
  end

  task :stop do
    "bundle exec thin stop -C config/thin-config.yml"
  end

  task :restart do
    "bundle exec thin restart -C config/thin-config.yml"
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'

end
