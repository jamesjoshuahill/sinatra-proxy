require 'spec_helper'
require './proxy'

describe 'Proxy' do

  def app
    Sinatra::Application
  end

  it "responds to GET '/' on port 9494" do
    get 'http://localhost:9494'
    expect(last_response).to be_ok
  end

end
