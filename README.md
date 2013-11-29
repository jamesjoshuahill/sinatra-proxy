# Ruby Test: Proxy

## The Problem

We have a server which requires an API key to be passed along with each request
and a client that we don't trust cause we're crazily paranoid, and a proxy
which we do trust.

The client can't talk directly to the server, so it talks to a proxy which
forwards the client's requests to the server with the API key added, returning
the response from the server to the client.

This would be great, except that the proxy file was at a party last night
and got so drunk he lost all his code. And somehow the cosmos has decided that
you are the unlucky soul who's got the responsibility to give the proxy new
code.

## Goal

You need to write a custom HTTP proxy/forwarder, which accepts requests from
`client.rb`, forwards them to `server.rb` adding a `X-API-Key` header, or
`api_key` query parameter to the request, and then returning the reponse to
the client.

You are free to use any ruby-based technology within reason to create your
proxy. As long as the client file outputs "OK" for both it's fetch calls.

Bonus points for clean code, tests, and asynchronous capabilities.

## Technical

### Setup

To install dependencies for this test with
[bundler](https://rubygems.org/gems/bundler) run:

     bundle install

### Running The Test

#### Server

The server is started with:

    bundle exec ruby server.rb

#### Client

Run the client to see result:

    bundle exec ruby client.rb

By default it tries to connect to port 4567, you can customize the port by
specifying the PORT environment variable.

## Response

I wrote the proxy in Sinatra. I chose to add the `X-API-Key` to the headers
of every request forwarded to the server.

The proxy is started with:

     bundle exec ruby proxy.rb
     
I have changed the default port of the proxy to `9494`, so that it does not
clash with the server running on the same host. You can customise the proxy
port by specifying the `PORT` environment variable.

I used RSpec for TDD, with WebMock and Rack::Test to stub the HTTP requests to
the server. I used Guard for continuous testing. To run the tests
`bundle install` and run `rspec`.
