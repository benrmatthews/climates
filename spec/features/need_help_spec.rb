require 'rails_helper'

feature 'Creating help request', js: true do
  let(:user) { create :user }
  let!(:topic1) { create :topic, title: 'super help', description: 'Help me!' }
  let!(:supporter) { create :user }

  before do
    authenticate_user(user)
    topic1.skills << create(:skill, user: supporter, topic: topic1)
  end

  scenario 'adding help request' do
    visit root_path
    click_on 'I need help'
    expect(page).to have_xpath('/html/body/main/div[2]/div[2]/div/a/span[3]')
    find("a[href='/topics/1']").click
    expect(page).to have_content("Need help with #{topic1.title}?")

    fill_in 'support_body', with: 'HELP ME!'
    click_on 'Ask for help'
    expect(page).to have_content("We asked #{supporter.first_name} to help you.")
    expect(current_path).to eq(root_path)
  end

  scenario 'skills counter shows correct value' do
    topic1.skills << create(:skill, topic: topic1)
    visit topics_path
    expect(page).not_to have_css('.item__count span', text: '1')
    expect(page).to have_css('.item__count span', text: '2')
  end
end
