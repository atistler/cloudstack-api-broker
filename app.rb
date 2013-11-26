require 'rubygems'
require 'sinatra'

set :server, %w[puma]
set :port, 3002
set :app_file, __FILE__

get '/client/api' do

end