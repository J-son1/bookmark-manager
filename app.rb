require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'
require './database_connection_setup'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

  # Go to bookmarks page.
  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end 

  # Delete a bookmark and return to bookmarks page.
  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])

    redirect '/bookmarks'
  end

  # Add a bookmark and return to bookmarks page.
  post '/bookmarks/add' do
    Bookmark.create(url: params[:url], title: params[:title])

    redirect '/bookmarks'
  end

  # Go to edit bookmark page.
  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])

    erb :'bookmarks/edit'
  end

  # Update a bookmark and return to bookmarks page.
  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])

    redirect '/bookmarks'
  end

  run! if app_file == $0
end
