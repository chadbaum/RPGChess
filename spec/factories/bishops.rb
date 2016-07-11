FactoryGirl.define do
  factory :bishop do

    trait :white do
      color 'white'
      x_position 7
      y_position 2
    end
    trait :black do
      color 'black'
      x_position 0
      y_position 2
    end
  end
end
