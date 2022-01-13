feature "Add bookmarks" do
  xscenario "add bookmarks to the bookmark list" do
    visit('/')
    fill_in 'url', with: 'http://youtube.com'
    fill_in 'title', with: 'YouTube'
    click_button 'Submit'

    expect(page).to have_link 'Youtube', href: 'http://www.youtube.com'
  end
end
