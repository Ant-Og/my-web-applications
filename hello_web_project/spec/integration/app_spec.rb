require 'spec_helper'
require 'rack/test'
require_relative    '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'GET /' do
    it 'returns 200 ok' do
      response = get('/')
      
      expect(response.status).to eq(200)
      expect(response.body).to eq('Hello!')
    end
  end 
  
  context 'POST /submit' do
    it 'returns Hello name and message' do
      response = post('/submit', name: 'Anthony', message: 'How are you?')
      
      expect(response.body).to eq('Thanks Anthony, you sent this message: How are you?')
    end
  end
end