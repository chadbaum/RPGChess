FactoryGirl.define do
  factory :game do
    trait :populated do
      after(:create, &:populate!)
    end
  end
end
