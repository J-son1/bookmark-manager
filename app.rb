require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :index 
  end 

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])

    redirect '/bookmarks'
  end

  post '/bookmarks/add' do
    Bookmark.create(url: params[:url], title: params[:title])

    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])

    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])

    redirect '/bookmarks'
  end

  run! if app_file == $0
end
