require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums' do
    it 'returns list of albums in the database' do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('Baltimore')
    end
  end

  context 'POST /albums' do
    it 'adds user inputed album to the database' do
      response = post('/albums', title: 'Voyage', 
        release_year: '2022', 
        artist_id: '2')

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')

      expect(response.body).to include('Voyage')
    end
  end
end
