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

  context 'GET /albums/:id' do
    it 'returns info about ablum 2' do
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Artist: Pixies')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Genre: Rock')
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

  context 'GET /artists' do
    it 'returns list of artists in the database' do
      response = get('/artists')

      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context 'POST /artists' do
    it 'adds user inputed album to the database' do
      response = post('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/artists')
      expect(response.body).to include('ABBA')
    end
  end
end
