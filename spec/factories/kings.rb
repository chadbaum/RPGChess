FactoryGirl.define do
  factory :king do
    trait :white do
      color 'white'
      x_position 3
      y_position 7
    end
    trait :black do
      color 'black'
      x_position 3
      y_position 0
    end
  end
end
