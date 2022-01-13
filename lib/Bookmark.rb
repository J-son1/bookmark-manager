require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'bookmark_manager_test'
    else 
      connection = PG.connect :dbname => 'bookmark_manager'
    end

    rows = connection.exec "SELECT * FROM bookmarks;"

    rows.map do |row|
      Bookmark.new(id: row['id'], url: row['url'], title: row['title'])
    end

  end 

  def self.create(title:, url:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'bookmark_manager_test'
    else 
      connection = PG.connect :dbname => 'bookmark_manager'
    end
    
    result = connection.exec "INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;"
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end
end 
