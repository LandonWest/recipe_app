# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe do
    name { Faker::Lorem.word }
    directions { Faker::Lorem.sentence(word_count = 20) }
  end
end
