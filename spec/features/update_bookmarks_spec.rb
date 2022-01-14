
feature 'Updating bookmarks' do 
  scenario 'a user can update a bookmark' do 
    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    visit '/bookmarks'
    expect(page).to have_link('Google', href: 'http://www.google.com')

    first('.bookmark').click_button('Edit')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in 'title', with: 'Youtube'
    fill_in 'url', with: 'http://www.youtube.com'
    click_button 'Submit'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Google', href: 'http://www.google.com')
    expect(page).to have_link('Youtube', href: 'http://www.youtube.com')
  end
end
