require 'bookmark'

describe Bookmark do
  let (:title) { 'title' }
  let (:url) { 'url' }
  subject (:bookmark) { described_class.new(title: title, url: url) }

  describe '#initialize' do
    it 'has a title' do
      expect(bookmark.title).to eq title
    end

    it 'has a url' do
      expect(bookmark.url).to eq url
    end
  end

  describe '#all' do 
    it 'returns all bookmarks' do 
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.makersacademy.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")

      expect(Bookmark.all).to include("http://www.makersacademy.com")
      expect(Bookmark.all).to include('http://www.google.com')
      expect(Bookmark.all).to include('http://www.destroyallsoftware.com')
    end
  end 

  describe '#create' do
    it 'adds a new bookmark to the database' do
      Bookmark.create('http://youtube.com', 'YouTube')
      expect(Bookmark.all).to include('http://youtube.com')
    end
  end

  describe '#title' do
    it 'shows the title for a bookmark' do
      Bookmark.create('http://youtube.com', 'YouTube')
      expect(Bookmark.title).to eq 'YouTube'
    end
  end
  
end 

        
