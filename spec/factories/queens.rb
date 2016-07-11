FactoryGirl.define do
  factory :queen do

    trait :white do
      color 'white'
      x_position 7
      y_position 4
    end
    trait :black do
      color 'black'
      x_position 0
      y_position 4
    end
  end
end
