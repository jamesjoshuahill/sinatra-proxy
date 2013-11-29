# encoding: utf-8

#
# Oh no! I lost my codez :'(
#
require 'sinatra'
require 'net/http'

set :port, ENV['PORT'] || 9494

get '/*' do
  client_request = Net::HTTP::Get.new(request.url)
  client_request['X-API-Key'] = 'awesomeserver'

  server_response = Net::HTTP.start('localhost', '4567') do |http|
    http.request(client_request)
  end
  
  status server_response.code
  server_response.body
end
