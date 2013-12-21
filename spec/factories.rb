FactoryGirl.define do
  factory :quiz do
    # f.sequence(:email) { |n| "foo#{n}@example.com" }
    name "Christmas Quiz"
  end
  factory :category do
    name "Pop Music Round"
  end
end