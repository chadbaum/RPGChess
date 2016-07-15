require 'rails_helper'

RSpec.describe King, type: :model do
    describe "King" do
    it "should have a type of King" do
      r = FactoryGirl.create(:king)
      expect(r.type).to eq("King")
    end

    it "should not be allowed to create a red king" do
      expect { FactoryGirl.create(:king, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
