require 'bookmark'

describe Bookmark do
  describe '#all' do 
    it 'returns all bookmarks' do 
      expect(Bookmark.all).to include('http://www.google.co.uk')
      expect(Bookmark.all).to include('http://www.makersacademy.com')
    end
  end 
end 

        
