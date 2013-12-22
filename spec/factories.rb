FactoryGirl.define do
  factory :quiz do
    # f.sequence(:email) { |n| "foo#{n}@example.com" }
    name "Christmas Quiz"
  end
  factory :category do
    name "Pop Music Round"
  end
  factory :question do
    question "How many reindeers does Santa have?"
    correct_answer "nine"
    altone_answer "one"
    alttwo_answer "two"
    altthree_answer "three"
  end
end