# require 'airbrake/capistrano'
require 'bundler/capistrano'
require 'capistrano-puma'

set :application, 'cab'
set :repository,  'git@minerva.dpcloud.com:cloud-products/cloudstack-api-broker.git'
set :user, 'root'
set :deploy_to, '/srv/app'
set :scm, :git
set :use_sudo, false


# Figure out the name of the current local branch
def current_git_branch
  branch = `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
  puts "*** Deploying branch #{branch}"
  branch
end

