require 'rails_helper'

feature 'Request Dashboard', js: true do
  let(:user) { create :user }
  let!(:topic1) { create :topic, title: 'super help', description: 'Help me!' }
  let!(:supporter) { create :user }
  let!(:support1) { create :support, body: 'Request for help 1!', done: true }
  let!(:support2) { create :support, body: 'Request for help 2!', done: false }

  before do
    authenticate_user(user)
    topic1.skills << create(:skill, user: supporter, topic: topic1)
  end

  scenario 'checks if correct request appears' do
    visit root_path
    click_on 'I need help'
    find("a[href='/topics/1']").click
    fill_in 'support_body', with: 'HELP ME!'
    click_on 'Ask for help'
    visit supports_path

    expect(page).to have_xpath('/html/body/main/div[2]/div[1]/table/tbody/tr')
    within('table.request') do
      expect(page).to have_content("HELP ME!")
    end
  end

  scenario 'searching for done requests shows only finished requests' do
    visit supports_path
    expect(page).to have_content('Request for help 1!')
    expect(page).to have_content('Request for help 2!')
    page.find('.filters-trigger.filters-hidden').click
    find(:xpath, "//*[@id='new_support_search']/div[3]/div[1]/div/label[3]").click
    click_on "Search"
    expect(page).to_not have_content('Request for help 2!')
    within('table.request') do
      expect(page).to have_content('Request for help 1!')
    end
  end


  scenario 'searching for undone requests shows only unfinished requests' do
    visit supports_path
    page.find('.filters-trigger.filters-hidden').click
    find(:xpath, "//*[@id='new_support_search']/div[3]/div[1]/div/label[4]").click
    click_on 'Search'
    expect(page).to_not have_content('Request for help 1!')
    within('table.request') do
      expect(page).to have_content('Request for help 2!')
    end
  end
end
