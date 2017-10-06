require 'rails_helper'

feature 'skills page', js: true do

  let(:user) { create :user }
  let!(:topic1) { create :topic, title: 'workshops' }
  let!(:topic2) { create :topic, title: 'mongo' }

  before do
    authenticate_user(user)
  end

  scenario "doesn't highlight deselected topic" do
    topic1.skills << create(:skill, user: user, topic: topic1)
    visit skills_path
    selector_css = "input.item.active[value='#{topic1.title} - you can help with that!']"
    expect(page).to have_selector(selector_css)
    find(selector_css).click
    selector_css = "input.item[value='#{topic1.title} - you are not helping yet.']"
    expect(page).to have_selector(selector_css)

    expect(find(selector_css)[:class]).to_not include 'active'
    expect(user.topics).to_not include(topic1)
  end

  scenario 'highlights selected topic' do
    visit skills_path
    selector_css = "input.item[value='#{topic1.title} - you are not helping yet.']"
    expect(page).to have_selector(selector_css)
    input = find(selector_css)
    expect(input[:class]).to_not include('active')
    find(selector_css).click
    selector_css = "input.item.active[value='#{topic1.title} - you can help with that!']"
    expect(page).to have_selector(selector_css)
    expect(user.topics).to include(topic1)
  end
end
