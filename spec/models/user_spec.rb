require 'spec_helper'

describe User do
  describe "presence" do
    it "fails validation with no cell_phone_number" do
      user = User.new
      user.should have(2).error_on(:cell_phone_number)
      user.errors[:cell_phone_number].should == ["can't be blank", "is not formatted properly"]
    end

    it "fails validation with no email" do
      user = User.new
      user.should have(2).error_on(:email)
      user.errors[:email].should == ["can't be blank", "is not formatted properly"]
    end

    it "fails validation with no name" do
      user = User.new
      user.should have(1).error_on(:name)
      user.errors[:name].should == ["can't be blank"]
    end

    it "fails validation with no language" do
      user = User.new
      user.should have(1).error_on(:language)
      user.errors[:language].should == ["can't be blank"]
    end

    it "fails validation with no time_zone" do
      user = User.new
      user.should have(1).error_on(:time_zone)
      user.errors[:time_zone].should == ["can't be blank"]
    end

    it "units is 0 by default" do
      user = User.new
      user.should have(0).error_on(:units)
      user.units.should eq(0)
    end

    it "fails validation with no units" do
      user = User.new(units: nil)
      user.should have(2).error_on(:units)
      user.errors[:units].should == ["can't be blank", "is not a number"]
    end

    it "fails validation with no username" do
      user = User.new
      user.should have(2).error_on(:username)
      user.errors[:username].should == ["can't be blank", "is not formatted properly"]
    end
  end

  describe "uniqueness" do
    it "fails validation with a duplicate cell_phone_number" do
      user = FactoryGirl.create(:user)
      duplicate = User.new(cell_phone_number: user.cell_phone_number)
      duplicate.should have(1).error_on(:cell_phone_number)
      duplicate.errors[:cell_phone_number].should == ["has already been taken"]
    end

    it "fails validation with a duplicate email" do
      user = FactoryGirl.create(:user)
      duplicate = User.new(email: user.email)
      duplicate.should have(1).error_on(:email)
      duplicate.errors[:email].should == ["has already been taken"]
    end

    it "fails validation with a duplicate username" do
      user = FactoryGirl.create(:user)
      duplicate = User.new(username: user.username)
      duplicate.should have(1).error_on(:username)
      duplicate.errors[:username].should == ["has already been taken"]
    end
  end

  describe "format" do
    it "fails validation with an incorrect format for email" do
      user = User.new(email: "email-without-at-symbol")
      user.should have(1).error_on(:email)
      user.errors[:email].should == ["is not formatted properly"]
    end

    it "fails validation with if the username is less than 3 characters" do
      user = User.new(username: "em")
      user.should have(1).error_on(:username)
      user.errors[:username].should == ["is not formatted properly"]
    end

    it "fails validation with if the username is more than 30 characters" do
      user = User.new(username: "aodptk39g-a35kdi93n-04kgm21gk-12")
      user.should have(1).error_on(:username)
      user.errors[:username].should == ["is not formatted properly"]
    end

    it "fails validation with if the username is not formatted properly" do
      user = User.new(username: "User Name 3379")
      user.should have(1).error_on(:username)
      user.errors[:username].should == ["is not formatted properly"]
    end
  end
end
