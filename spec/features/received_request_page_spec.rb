require 'rails_helper'

feature 'Received help request page', js: true do 
  let(:user) { create :user, first_name: 'John' }
  let!(:support) { create :support, user: user, receiver: receiver, body: 'help me!' }
  let(:receiver) { create :user }

  before do
    authenticate_user(user)
    visit support_path(support)
  end

  scenario 'marks request as resolved' do
    click_link('Acknowledge!')
    expect(page).to have_content('Support acknowledged! now get this thing done!')
    expect(page).to have_content("#{user.first_name} acknowledged this support")
    page.evaluate_script('window.confirm = function() { return true; }')
    click_link('Mark as resolved')
    expect(page).to have_content('Finished helping. Awesome!')
    expect(current_path).to eq(root_path)
  end

  scenario 'adds comment with body' do
    find('#comment_body').set('I will help you')
    click_button('Comment')
    expect(page).to have_content('You contributed to this support request')
    expect(page).to have_content("#{user.first_name} wrote")
    expect(page).to have_content('I will help you')
  end

  scenario "doesn't add comment without body" do
    find('#comment_body')
    click_button('Comment')
    expect(page).to_not have_content('You contributed to this support request')
  end
end