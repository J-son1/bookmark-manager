feature "Add bookmarks" do
  scenario "add bookmarks to the bookmark list" do
    visit('/bookmarks')
    fill_in 'url', with: 'https://youtube.com'
    fill_in 'title', with: 'YouTube'
    click_button 'Submit'   
    expect(page).to have_content('YouTube')
  end
end
