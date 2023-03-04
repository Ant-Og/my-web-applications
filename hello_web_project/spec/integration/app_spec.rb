require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do

  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'GET /hello' do
    it 'returns 200 ok' do
      response = get('/hello?name=Anthony')
      
      expect(response.status).to eq(200)
      expect(response.body).to eq('Hello Anthony')
    end
  end 
  
  context 'POST /submit' do
    it 'returns Hello name and message' do
      response = post('/submit', name: 'Anthony', message: 'How are you?')
      
      expect(response.status).to eq(200)
      expect(response.body).to eq('Thanks Anthony, you sent this message: How are you?')
    end
  end
  
  context 'GET /names' do
    it 'returns a string of names' do
      response = get('/names?names=Anthony, Tony, Tone')

      expect(response.status).to eq(200)
      expect(response.body).to eq('Anthony, Tony, Tone')
    end
  end

#   context 'POST /sort-names' do
#     it 'returns a string of names sorted in alphabetical order' do
#       response = post('/sort-names', names: 'Will, Anthony, JC, Henry')
      
#       expect(response.status).to eq(200)
#       expect(response.body).to eq('Anthony Henry, JC, Will')
#     end
#   end
end
