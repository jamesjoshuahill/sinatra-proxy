# Sinatra Proxy

This Ruby code test was set by a London tech company.

## The challenge

To write a custom HTTP proxy/forwarder, which forwards requests from
`client.rb` to `server.rb`. The proxy should add an `X-API-Key` header, or
`api_key` query parameter, to the request to authenticate with the server.
And it should return the server's reponse to the client.

## My response

I wrote the proxy in Sinatra and chose to add the `X-API-Key` to the headers
of every request forwarded to the server.

I used RSpec for TDD, with WebMock and Rack::Test to stub the HTTP requests to
the server. I used Guard for continuous testing. To run the tests
`bundle install` and run `rspec`.

To run the tests, first install the dependencies:

     bundle install

Then start the server, proxy and client in three separate sessions with:

     bundle exec ruby server.rb
     
     bundle exec ruby proxy.rb
     
     bundle exec ruby client.rb

The default port of the proxy is `9494`, so that it does not clash with the
server when they are run on the same host. You can customise the proxy port
by specifying the `PORT` environment variable.
