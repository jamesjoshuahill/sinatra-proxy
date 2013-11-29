require 'spec_helper'
require './proxy'

describe 'Proxy' do

  def app
    Sinatra::Application
  end

  let(:get_root) { get "http://localhost:#{ENV['PORT']}" }

  it "responds to GET requests" do
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

  context 'with the X-API-Key header' do

    it "adds the API key to the header" do
      server_request = stub_request(:get, 'http://localhost:4567').
                         with(:headers => { 'X-API-Key' => 'awesomeserver' })
      get_root
      expect(server_request).to have_been_requested
    end

    it "returns the server's response" do
      server_request = stub_request(:get, 'http://localhost:4567').
                         with(:headers => { 'X-API-Key' => 'awesomeserver' }).
                         to_return(:body => 'welcome')
      response = get_root
      expect(response.body).to eq 'welcome'
    end

  end

end
