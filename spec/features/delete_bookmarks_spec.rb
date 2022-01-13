feature 'Deleting bookmarks' do 
  scenario 'a user can delete a bookmark' do 
    Bookmark.create(url: 'http://www.google.com', title: 'Google')
    visit '/'
    expect(page).to have_link('Google', href: 'http://www.google.com')

    first('.bookmark').click_button 'Delete'

    expect(page).not_to have_link('Google', href: 'http://www.google.com')
  end
end