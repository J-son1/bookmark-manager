require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    p @bookmarks
    erb(:index)
  end 

  post '/add' do
    # get url and title from form
    url = params[:url]
    title = params[:title]
    
    # send bookmark to database
    Bookmark.create(url, title)

    redirect('/bookmarks')
  end

  run! if app_file == $0
end