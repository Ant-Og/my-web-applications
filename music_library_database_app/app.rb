# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  def invalid_request_parameters?
    # Are the params nil?
    return true if params[:title] == nil || params[:release_year] == nil || 
    params[:artist_id] == nil
  
    # Are they empty strings?
    return true if params[:title] == "" || params[:release_year] == "" ||
    params[:artist_id] == ""

    return false
  end

  get '/' do
    return erb(:index)
  end

  get '/about' do
    return erb(:about)
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    
    return erb(:allAlbums)
  end

  get '/albums/new' do 
    return erb(:newAlbum)
  end

  get '/albums/:id' do
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = album_repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  post '/albums' do
    if invalid_request_parameters?
      status 400
      return erb(:error)
    end

    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)

    return ''
  end

  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all

    response = artists.map do |artist|
      artist.name
    end.join(', ')

    return response
  end

  post '/artists' do
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)

    return ''
  end
end

  # get '/albums' do
  #   repo = AlbumRepository.new
  #   albums = repo.all

  #   response = albums.map do |album|
  #     album.title
  #   end.join(', ')

  #   return response
  #   return erb(albums)
  # end