# encoding: utf-8

require 'net/http'
require 'uri'

port = ENV['PORT'] || '4567'

print 'Fetching "/"... '
res = Net::HTTP.start('localhost', port) { |h| h.get('/') }
puts (res.code == '200' && res.body == 'welcome') ? 'OK' : 'FAIL'

print 'Fetching "/hello_world"... '
res = Net::HTTP.start('localhost', port) { |h| h.get('/hello_world') }
puts (res.code == '200' && res.body == 'hello world') ? 'OK' : 'FAIL'
