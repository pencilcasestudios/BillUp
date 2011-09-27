require 'spec_helper'

describe Organisation do
  describe "format" do
    it "fails validation if inovices_left is not a number" do
      organisation = Organisation.new(invoices_left: "Something that is not a number")
      organisation.should have(1).error_on(:invoices_left)
      organisation.errors[:invoices_left].should == ["is not a number"]
    end

    it "fails validation if receipts_left is not a number" do
      organisation = Organisation.new(receipts_left: "Something that is not a number")
      organisation.should have(1).error_on(:receipts_left)
      organisation.errors[:receipts_left].should == ["is not a number"]
    end
  end

  describe "presence" do
    it "fails validation when inovices_left is nil" do
      organisation = Organisation.new(invoices_left: nil)
      organisation.should have(2).error_on(:invoices_left)
      organisation.errors[:invoices_left].should == ["can't be blank", "is not a number"]
    end

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

    it "fails validation when receipts_left is nil" do
      organisation = Organisation.new(receipts_left: nil)
      organisation.should have(2).error_on(:receipts_left)
      organisation.errors[:receipts_left].should == ["can't be blank", "is not a number"]
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
