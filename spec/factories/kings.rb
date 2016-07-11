FactoryGirl.define do
  factory :king do

    trait :white do
      color 'white'
      x_position 7
      y_position 3
    end
    trait :black do
      color 'black'
      x_position 0
      y_position 3
    end
  end
end
