# encoding: utf-8

#
# Oh no! I lost my codez :'(
#
require 'sinatra'
require 'net/http'

set :port, ENV['PORT'] || 9494

get '/*' do
  forward = Net::HTTP::Get.new(request.url)
  forward['X-API-Key'] = 'awesomeserver'
  Net::HTTP.start('localhost', '4567') { |http| http.request(forward) }.body
end
