# player Model
class Player < ApplicationRecord
  has_many :pieces
  belongs_to :game
  belongs_to :user
end
