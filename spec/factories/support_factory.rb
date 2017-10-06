FactoryGirl.define do
  factory :support, class: Support do
    user
    topic
    body Forgery(:lorem_ipsum).words(10)
  end

  factory :done_support, parent: :support do
    done true
  end
end
