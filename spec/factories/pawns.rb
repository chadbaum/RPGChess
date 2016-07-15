FactoryGirl.define do
  factory :pawn do

    trait :moved do
      y_position 5
    end

    trait :white do
      color 'white'
      x_position 5
      y_position 6
    end

    trait :black do
      color 'black'
      x_position 5
      y_position 1
    end
  end
end
