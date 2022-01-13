require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

  get '/' do
    @bookmarks = Bookmark.all
    erb(:index)
  end 

  delete '/:id' do
    Bookmark.delete(id: params[:id])
    redirect('/')
  end

  post '/add' do
    # send bookmark to database
    Bookmark.create(url: params[:url], title: params[:title])

    redirect('/')
  end

  get '/:id/update' do
    p params
    @bookmark_id = params[:id]
    erb :update
  end

  patch '/:id/update' do
    p params
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    
    redirect('/')
  end

  run! if app_file == $0
end