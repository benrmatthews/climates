require 'rails_helper'

feature 'Ranking page', js: true do 

  let(:user) { create :user_with_supports, supports_count: 8 }
  let(:done_support2) { create :done_support, user: user }

  before do
    authenticate_user(user)
  end

  scenario 'checks users points' do
    visit users_path
    expect(page).to have_content('Best supporters!')
    within(:xpath, '/html/body/main/section/div/div[3]') do
      within('.position__score') do
        expect(page).to have_content('8')
      end
      find(:xpath, '/html/body/main/section/div/div[3]/div/ol/li/a').click
    end
    expect(all('li.support').count).to eq(8)
  end

  scenario 'shows weekly and all requests ' do
    FinishSupport.new(user, done_support2).commence!
    done_support2.update_attributes(updated_at: 30.days.ago)
    visit users_path
    within(:xpath, '/html/body/main/section/div/div[3]') do
      within('.position__score') do
        expect(page).to have_content('8')
      end
    end
     within(:xpath, '/html/body/main/section/div/div[5]') do
      within('.position__score') do
        expect(page).to have_content('9')
      end
    end
  end
end
