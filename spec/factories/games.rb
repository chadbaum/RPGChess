FactoryGirl.define do
  factory :game do
    trait :populated do
      after(:create) { |game| game.populate! }
    end
  end
end
