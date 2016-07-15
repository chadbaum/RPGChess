require 'rails_helper'

RSpec.describe Bishop, type: :model do
    describe "Bishop" do
    it "should have a type of Bishop" do
      r = FactoryGirl.create(:bishop)
      expect(r.type).to eq("Bishop")
    end

    it "should not be allowed to create a red bishop" do
      expect { FactoryGirl.create(:bishop, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
