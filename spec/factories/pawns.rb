FactoryGirl.define do
  factory :pawn do
    type 'Pawn'

    trait :moved do
      x_position 5
    end

    trait :white do
      color 'white'
      x_position 6
      y_position 5
    end

    trait :black do
      color 'black'
      x_position 1
      y_position 5
    end
  end
end
