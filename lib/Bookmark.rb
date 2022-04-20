# require_relative '../database_connection_setup'
require_relative './database_connection'
require 'uri'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def comments
    result = DatabaseConnection.query(
      sql:
        "SELECT * FROM comments "\
        "WHERE bookmark_id = $1;",
      params:
        [id]
    )
  end

  def self.all
    result = DatabaseConnection.query sql: "SELECT * FROM bookmarks;"

    result.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'],
        url: bookmark['url'],
        title: bookmark['title']
      )
    end
  end 

  def self.create(title:, url:)
    return false unless is_url?(url)
    result = DatabaseConnection.query(
      sql: 
        "INSERT INTO bookmarks (url, title) "\
        "VALUES($1, $2) "\
        "RETURNING id, url, title;",
      params: 
        [url, title]
    )

    Bookmark.new(
      id: result[0]['id'],
      title: result[0]['title'],
      url: result[0]['url']
    )
  end

  def self.delete(id:)
    DatabaseConnection.query(
      sql:
        "DELETE FROM bookmarks "\
        "WHERE id = $1",
      params:
        [id]
    )
  end

  def self.update(id:, title:, url:)
    result = DatabaseConnection.query(
      sql:
        "UPDATE bookmarks "\
        "SET title = $1, url = $2 "\
        "WHERE id = $3 "\
        "RETURNING id, title, url;",
      params:
        [title, url, id]
    )

    Bookmark.new(
      id: result[0]['id'],
      title: result[0]['title'],
      url: result[0]['url']
    )
  end

  def self.find(id:)
    result = DatabaseConnection.query(
      sql:
        "SELECT * FROM bookmarks "\
        "WHERE id = $1",
      params:
        [id]
    )
    
    Bookmark.new(
      id: result[0]['id'],
      title: result[0]['title'],
      url: result[0]['url']
    )
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http','https'])}\z/
  end
end
