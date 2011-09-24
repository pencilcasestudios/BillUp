require 'spec_helper'

describe Organisation do
  describe "presence" do
    it "fails validation with no name" do
      organisation = Organisation.new
      organisation.should have(1).error_on(:name)
      organisation.errors[:name].should == ["can't be blank"]
    end

    it "fails validation with no subdomain" do
      organisation = Organisation.new
      organisation.should have(1).error_on(:subdomain)
      organisation.errors[:subdomain].should == ["can't be blank"]
    end
  end

  describe "uniqueness" do
    it "fails validation with a duplicate subdomain" do
      organisation = Factory(:organisation)
      duplicate = Organisation.new(subdomain: organisation.subdomain)
      duplicate.should have(1).error_on(:subdomain)
      duplicate.errors[:subdomain].should == ["has already been taken"]
    end
  end
end
