FactoryGirl.define do
  factory :rook do
    
    trait :white do
      color 'white'
      x_position 7
      y_position 7
    end
    trait :black do
      color 'black'
      x_position 0
      y_position 0
    end
  end
end
