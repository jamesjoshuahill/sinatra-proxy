# encoding: utf-8

require 'rubygems'
require 'sinatra'


before do
  # check for API key in `X-API-Key` header or `api_key` query param
  halt 400 if (env['HTTP_X_API_KEY'] || params['api_key']) != 'awesomeserver'
end

get '/' do
  "welcome"
end

get '/hello_world' do
  "hello world"
end
