# encoding: utf-8

#
# Oh no! I lost my codez :'(
#
require 'sinatra'
require 'net/http'

set :port, ENV['PORT'] || 9494

get '/' do
  Net::HTTP.get('localhost', '/', '4567')
end

get '/hello_world' do
  Net::HTTP.get('localhost', '/hello_world', '4567')
end
