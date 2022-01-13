feature "Add bookmarks" do
  scenario "add bookmarks to the bookmark list" do
    visit('/')
    fill_in 'url', with: 'http://www.youtube.com'
    fill_in 'title', with: 'YouTube'
    click_button 'Submit'

    expect(page).to have_link 'YouTube', href: 'http://www.youtube.com'
  end
end
