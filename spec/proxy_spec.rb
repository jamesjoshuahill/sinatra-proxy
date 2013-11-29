require 'spec_helper'
require './proxy'

describe 'Proxy' do

  def app
    Sinatra::Application
  end

  let(:proxy)  { "http://localhost:#{ENV['PORT']}" }
  let(:server) { "http://localhost:4567" }
  let(:api_key_header) { { 'X-API-Key' => "awesomeserver"} }

  def server_request(path, response = nil)
    @server_request = stub_request(:get, server + path).
                       with(:headers => api_key_header)
    @server_request.to_return(response) if response
    get proxy + path
  end

  def expect_request_to_server(path)
    server_request(path)
    expect(@server_request).to have_been_requested
  end

  it "responds to GET requests" do
    stub_request(:get, server)
    get proxy
    expect(last_response).to be_ok
  end

  context 'forwards GET requests to the server with the API key' do

    example "GET '/'" do
      expect_request_to_server('/')
    end

    example "GET '/hello_world'" do
      expect_request_to_server('/hello_world')
    end

    example "GET '/something_else'" do
      expect_request_to_server('/something_else')
    end

  end

  context "when returning the server's response it forwards the" do

    example "body" do
      response = server_request('/', { :body => 'welcome' })
      expect(response.body).to eq 'welcome'
    end

    example "status code" do
      response = server_request('/', { :status => 400 })
      expect(response.status).to eq 400
    end

  end

end
