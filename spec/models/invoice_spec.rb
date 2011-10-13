require 'spec_helper'

describe Invoice do
  describe "presence" do
    it "fails validation with no description" do
      invoice = Invoice.new
      invoice.should have(1).error_on(:description)
      invoice.errors[:description].should == ["can't be blank"]
    end

    it "fails validation with no from" do
      invoice = Invoice.new
      invoice.should have(1).error_on(:from)
      invoice.errors[:from].should == ["can't be blank"]
    end

    it "fails validation with no from_address" do
      invoice = Invoice.new
      invoice.should have(1).error_on(:from_address)
      invoice.errors[:from_address].should == ["can't be blank"]
    end

    it "fails validation with no to" do
      invoice = Invoice.new
      invoice.should have(1).error_on(:to)
      invoice.errors[:to].should == ["can't be blank"]
    end

    it "fails validation with no to_address" do
      invoice = Invoice.new
      invoice.should have(1).error_on(:to_address)
      invoice.errors[:to_address].should == ["can't be blank"]
    end
  end
  
  describe "uniqueness" do
  end
end
