require 'rails_helper'

feature 'user_profile', js: true do

  let!(:user) { create :user_with_supports_and_skills, supports_count: 2, skills_count: 2, first_name: "Marta"}
  let!(:topic1) { create :topic, title: 'super help', description: 'Help me!' }
  let!(:support) { create :support, user: user, topic: topic1, body: "Hi, please help me!", done: true }


  before do
    authenticate_user(user)
    topic1.users << user
    user.update_attributes(supports_count: 3)
  end

  scenario 'going to user profile from requests dashboard' do
    visit supports_path
    find(:xpath, '/html/body/main/div[2]/div[1]/table/tbody/tr[1]/td[6]/a').click
    expect(current_path).to eq(user_path(user))
  end

  scenario "user's skills are rendering correctly" do
    visit user_path(user)
    within('.user_skills.box--rounded') do
      expect(page).to have_content(topic1.title)
    end
  end

  scenario "user's solved requests are rendering correctly" do
    visit user_path(user)
    within('.supports.box--rounded') do
      expect(page).to have_content(support.topic.title)
    end
  end

  scenario "user's counter of solved requests is rendering correctly" do
    visit user_path(user)
    within('.subheader-line') do
      expect(page).to have_content(user.supports_count)
    end
  end
end
