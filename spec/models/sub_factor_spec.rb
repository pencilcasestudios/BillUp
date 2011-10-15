require 'spec_helper'

describe SubFactor do
  describe "presence" do
    it "amount is 0 by default" do
      sub_factor = SubFactor.new
      sub_factor.should have(0).error_on(:amount)
      sub_factor.amount.should eq(0)
    end

    it "fails validation with no amount" do
      sub_factor = SubFactor.new(amount: nil)
      sub_factor.should have(2).error_on(:amount)
      sub_factor.errors[:amount].should == ["can't be blank", "is not a number"]
    end

    it "fails validation with no units" do
      sub_factor = SubFactor.new
      sub_factor.should have(1).error_on(:units)
      sub_factor.errors[:units].should == ["can't be blank"]
    end
  end

  describe "format" do
    it "fails validation if amount is not a number" do
      sub_factor = SubFactor.new(amount: "Something that is not a number")
      sub_factor.should have(1).error_on(:amount)
      sub_factor.errors[:amount].should == ["is not a number"]
    end
  end
end
