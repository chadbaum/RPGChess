FactoryGirl.define do
  factory :pawn do
    color 'white'
    type 'Pawn'
    x_position 6
    y_position 5

    trait :moved do
      x_position 5
    end
  end
end
