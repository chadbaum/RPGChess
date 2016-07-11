require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "pawn movement validation" do

    it "should return false if the pawn is not being moved from its original location" do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.valid_move?(6,5).to eq(false))
    end

  end
end
