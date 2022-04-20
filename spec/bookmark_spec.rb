require 'bookmark'

describe Bookmark do
  describe '.all' do 
    it 'returns all bookmarks' do 

      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy All Software")
      Bookmark.create(url: "http://www.google.com", title: "Google")
      
      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end 

  describe '.create' do
    it 'adds a new bookmark to the database' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.example.org'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')

      expect(Bookmark.all).to be_empty
    end
  end

  describe '.delete' do 
    it 'deletes a bookmark from the database' do 
      bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')

      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end  

  describe '.update' do
    it 'updates a bookmark from the database' do
      bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.youtube.com', title: 'YouTube')
      
      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'YouTube'
      expect(updated_bookmark.url).to eq 'http://www.youtube.com'
    end
  end

  describe '.find' do
    it 'returns a given bookmark from the database' do
      bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Google'
      expect(result.url).to eq 'http://www.google.com'
    end
  end

  describe '#comments' do
    it 'returns a list of comments on the bookmark' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      DatabaseConnection.query(
        sql:
          "INSERT INTO comments (id, text, bookmark_id) "\
          "VALUES(1, 'Test comment', $1)",
        params:
          [bookmark.id]
      )

      comment = bookmark.comments.first

      expect(comment['text']).to eq 'Test comment'
    end
  end
end 
