FactoryGirl.define do

  factory :topic, class: Topic do
    sequence(:title) { |n| "topic no. #{n}" }
    description 'Lorem ipsum'
  end

end
