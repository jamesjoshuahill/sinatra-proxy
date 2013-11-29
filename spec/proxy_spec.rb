require 'spec_helper'
require './proxy'

describe 'Proxy' do

  def app
    Sinatra::Application
  end

  let(:get_root) { get "http://localhost:#{ENV['PORT']}" }

  it "responds to GET '/' on PORT" do
    stub_request(:get, 'http://localhost:4567')
    get_root
    expect(last_response).to be_ok
  end

  context 'forwards GET requests to the server' do

    example "GET '/'" do
      server_request = stub_request(:get, 'http://localhost:4567')
      get_root
      expect(server_request).to have_been_requested
    end

    example "GET '/hello_world'" do
      server_request = stub_request(:get, 'http://localhost:4567/hello_world')
      get "http://localhost:#{ENV['PORT']}/hello_world"
      expect(server_request).to have_been_requested
    end

    example "GET '/something_else'" do
      server_request = stub_request(:get, 'http://localhost:4567/something_else')
      get "http://localhost:#{ENV['PORT']}/something_else"
      expect(server_request).to have_been_requested
    end

  end

end
