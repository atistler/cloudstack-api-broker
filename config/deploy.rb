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

def thin_exec(cmd)
  on roles(:app) do
    "cd #{current_path}; thin #{cmd.to_s} -C config/thin/#{fetch(:environment)}.yml"
  end
end


namespace :deploy do
  desc 'Start thin'
  task :start do
    thin_exec :start
  end

  desc 'Stop thin'
  task :stop do
    thin_exec :stop
  end

  desc 'Restart thin'
  task :restart do
    on roles(:app) do
      puts "Restarting thin"
      "cd #{current_path}; thin #{cmd.to_s} -C config/thin/#{fetch(:environment)}.yml"
    end
  end


  after :finishing, 'deploy:restart'

  after :finishing, 'deploy:cleanup'

end
