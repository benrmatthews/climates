FactoryGirl.define do

  factory :user, class: User do
    first_name { Forgery(:name).first_name }
    sequence(:email) { |n| "user#{n}@email.com" }
  end

  factory :user_with_supports, parent: :user do

    after(:create) do |user, evaluator|
      user.supports_count.times do
        create(:done_support, user: user)
      end
    end
  end

  factory :user_with_supports_and_skills, parent: :user_with_supports do
    after(:create) do |user, evaluator|
      user.skills_count.times do
        create(:skill, user: user)
      end
    end
  end
end
