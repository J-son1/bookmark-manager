feature "Add bookmarks" do
  scenario "add bookmarks to the bookmark list" do
    visit '/bookmarks'
    
    fill_in 'url', with: 'http://www.youtube.com'
    fill_in 'title', with: 'YouTube'
    click_button 'Submit'

    expect(page).to have_link 'YouTube', href: 'http://www.youtube.com'
  end

  scenario 'the bookmark must be a valid URL' do
    visit '/bookmarks'
    fill_in 'url', with: 'not a real bookmark'
    click_button 'Submit'

    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'You must submit a valid URL.'
  end
end
