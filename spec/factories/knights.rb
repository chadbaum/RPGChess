FactoryGirl.define do
  factory :knight do

    trait :white do
      color 'white'
      x_position 7
      y_position 1
    end
    trait :black do
      color 'black'
      x_position 0
      y_position 1
    end
  end
end
