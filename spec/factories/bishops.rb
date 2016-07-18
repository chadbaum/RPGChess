FactoryGirl.define do
  factory :bishop do

    trait :white do
      color 'white'
      x_position 2
      y_position 7
    end

    trait :black do
      color 'black'
      x_position 2
      y_position 0
    end
  end
  
end
