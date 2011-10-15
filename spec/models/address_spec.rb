require 'spec_helper'

describe Address do
  describe "presence" do
    it "fails validation with no label" do
      address = Address.new
      address.should have(1).error_on(:label)
      address.errors[:label].should == ["can't be blank"]
    end

    it "fails validation with no street" do
      address = Address.new
      address.should have(1).error_on(:street)
      address.errors[:street].should == ["can't be blank"]
    end

    it "fails validation with no town" do
      address = Address.new
      address.should have(1).error_on(:town)
      address.errors[:town].should == ["can't be blank"]
    end

    it "fails validation with no country" do
      address = Address.new
      address.should have(1).error_on(:country)
      address.errors[:country].should == ["can't be blank"]
    end
  end
  
  describe "format" do
    it "fails validation with an incorrect format for email" do
      address = Address.new(email: "improperly formatted email")
      address.should have(1).error_on(:email)
      address.errors[:email].should == ["is not formatted properly"]
    end

    it "fails validation with an incorrect format for website" do
      address = Address.new(website: "improperly formatted website")
      address.should have(1).error_on(:website)
      address.errors[:website].should == ["is not formatted properly"]
    end

    it "fails validation with an incorrect format for land_line_number" do
      address = Address.new(land_line_number: "improperly formatted land_line_number")
      address.should have(1).error_on(:land_line_number)
      address.errors[:land_line_number].should == ["is not formatted properly"]
    end

    it "fails validation with an incorrect format for cell_phone_number" do
      address = Address.new(cell_phone_number: "improperly formatted cell_phone_number")
      address.should have(1).error_on(:cell_phone_number)
      address.errors[:cell_phone_number].should == ["is not formatted properly"]
    end

    it "fails validation with an incorrect format for fax_number" do
      address = Address.new(fax_number: "improperly formatted fax_number")
      address.should have(1).error_on(:fax_number)
      address.errors[:fax_number].should == ["is not formatted properly"]
    end
  end

  describe "uniqueness" do
    #it "fails validation with a duplicate label" do
    #  address = Factory(:address)
    #  duplicate = Address.new(label: address.label)
    #  duplicate.should have(1).error_on(:label)
    #  duplicate.errors[:label].should == ["has already been taken"]
    #end
  end
end
