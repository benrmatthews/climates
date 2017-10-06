require 'rails_helper'

feature 'Home page', js: true do 
  let(:user) { create :user, first_name: 'John' }
  let!(:support) { create :support, user: user, receiver: receiver, body: 'help me!', created_at: 1.day.ago }
  let!(:support2) { create :support }
  let(:receiver) { create :user }

  before do
    authenticate_user(user)
  end

  scenario 'resolved request shows in proper tab' do
    visit root_path
    expect(page).to have_content('We already solved 0 requests but there are still 2 requests to solve.')
    find(:xpath, '//*[@id="pending_requests"]/ul/li[2]/a').click
    expect(page).to have_content('topic no. 1')
    click_link('Acknowledge!')
    page.evaluate_script('window.confirm = function() { return true; }')
    click_link('Mark as resolved')
    expect(current_path).to eq(root_path)
    expect(page).to have_content('We already solved 1 requests but there are still 1 requests to solve.')
    within('#pending_requests') do
      expect(page).to have_content('topic no. 2')
      expect(page).to_not have_content('topic no. 1')
      expect(page).to have_selector('.new.support', '.ok.support', '.worring.support', '.critical.support')
    end
    click_link('Recently helped')
    within('#recently_helped') do
      expect(page).to have_content('topic no. 1')
      expect(page).to_not have_content('topic no. 2')
      expect(page).to have_selector('.done.support')
    end
  end
end