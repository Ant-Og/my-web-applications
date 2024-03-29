require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get "/hello" do
    @name = params[:name]
    return erb(:index)
  end
  
  # Old method 
  # get "/hello" do
  #   name = params[:name]
  #   return "Hello #{name}"
  # end

  post "/submit" do
    name = params[:name]
    message = params[:message]
    return "Thanks #{name}, you sent this message: #{message}"
  end

  get "/names" do
    names = params[:names]
    return "#{names}"
  end

  post "/sort-names" do
    names = params[:names]
    return names.split(", ").sort.join(", ")
  end
end