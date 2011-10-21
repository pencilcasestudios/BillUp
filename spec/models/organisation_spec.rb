require 'spec_helper'

describe Organisation do
  describe "presence" do
    it "fails validation when leaves_left is nil" do
      organisation = Organisation.new(leaves_left: nil)
      organisation.should have(2).error_on(:leaves_left)
      organisation.errors[:leaves_left].should == ["can't be blank", "is not a number"]
    end

    it "fails validation when preferred_due_in_period is nil" do
      organisation = Organisation.new(preferred_due_in_period: nil)
      organisation.should have(2).error_on(:preferred_due_in_period)
      organisation.errors[:preferred_due_in_period].should == ["can't be blank", "is not a number"]
    end

    it "preferred_due_in_period is 28 by default" do
      organisation = Organisation.new
      organisation.should have(0).error_on(:preferred_due_in_period)
      organisation.preferred_due_in_period.should eq(28)
    end

    it "fails validation with no name" do
      organisation = Organisation.new
      organisation.should have(1).error_on(:name)
      organisation.errors[:name].should == ["can't be blank"]
    end

    it "fails validation with no subdomain" do
      organisation = Organisation.new
      organisation.should have(2).error_on(:subdomain)
      organisation.errors[:subdomain].should == ["can't be blank", "is not formatted properly"]
    end
  end

  describe "uniqueness" do
    it "fails validation with a duplicate subdomain" do
      sequence = Time.now.strftime("%s")
      organisation = Factory(:organisation, :name => "Raiders of the Lost Arc #{sequence}", :subdomain => "raidersofthelostarc#{sequence}")
      duplicate = Organisation.new(subdomain: organisation.subdomain)
      duplicate.should have(1).error_on(:subdomain)
      duplicate.errors[:subdomain].should == ["has already been taken"]
    end
  end

  describe "format" do
    it "fails validation if preferred_due_in_period is not a number" do
      organisation = Organisation.new(preferred_due_in_period: "Something that is not a number")
      organisation.should have(1).error_on(:preferred_due_in_period)
      organisation.errors[:preferred_due_in_period].should == ["is not a number"]
    end

    it "fails validation if inovices_left is not a number" do
      organisation = Organisation.new(leaves_left: "Something that is not a number")
      organisation.should have(1).error_on(:leaves_left)
      organisation.errors[:leaves_left].should == ["is not a number"]
    end
  end

  describe "range" do
    it "fails validation if preferred_due_in_period is less than 0" do
      organisation = Organisation.new(preferred_due_in_period: 0)
      organisation.should have(1).error_on(:preferred_due_in_period)
      organisation.errors[:preferred_due_in_period].should == ["must be greater than 0"]
    end
  end
end
