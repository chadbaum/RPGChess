require 'rails_helper'

RSpec.describe Pawn, type: :model do
    describe "Pawn" do
    it "should have a type of Pawn" do
      r = FactoryGirl.create(:pawn)
      expect(r.type).to eq("Pawn")
    end

    it "should not be allowed to create a red pawn" do
      expect { FactoryGirl.create(:pawn, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
