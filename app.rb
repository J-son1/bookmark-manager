require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @bookmarks = Bookmark.all

    erb(:index)
  end 

  post '/bookmarks' do
    # send bookmark to database
    Bookmark.create(url: params[:url], title: params[:title])

    redirect('/')
  end

  run! if app_file == $0
end