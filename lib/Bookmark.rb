require 'pg'

class Bookmark
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'bookmark_manager_test'
    else 
      connection = PG.connect :dbname => 'bookmark_manager'
    end
    rows = connection.exec "SELECT * FROM bookmarks;"

    # each row is a hash
    rows.map { |row| row['url'] }
  end 

  def self.create(url, title)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'bookmark_manager_test'
    else 
      connection = PG.connect :dbname => 'bookmark_manager'
    end
    connection.exec "INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}');"
  end

  def self.title
    "YouTube"
  end
end 
