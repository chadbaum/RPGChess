FactoryGirl.define do
  factory :game do
    trait :populated do
      after(:create, &:create_players!)
      after(:create, &:populate!)
    end
  end
end
