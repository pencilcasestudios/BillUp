require 'spec_helper'

describe Receipt do
  describe "presence" do
    it "fails validation with no from" do
      receipt = Receipt.new
      receipt.should have(1).error_on(:from)
      receipt.errors[:from].should == ["can't be blank"]
    end

    it "fails validation with no from_address" do
      receipt = Receipt.new
      receipt.should have(1).error_on(:from_address)
      receipt.errors[:from_address].should == ["can't be blank"]
    end

    it "fails validation with no to" do
      receipt = Receipt.new
      receipt.should have(1).error_on(:to)
      receipt.errors[:to].should == ["can't be blank"]
    end

    it "fails validation with no to_address" do
      receipt = Receipt.new
      receipt.should have(1).error_on(:to_address)
      receipt.errors[:to_address].should == ["can't be blank"]
    end

    it "fails validation with no uuid" do
      receipt = Receipt.new
      receipt.should have(1).error_on(:uuid)
      receipt.errors[:uuid].should == ["can't be blank"]
    end

    it "fails validation with no receipt_number" do
      receipt = Receipt.new
      receipt.should have(2).error_on(:receipt_number)
      receipt.errors[:receipt_number].should == ["can't be blank", "is not a number"]
    end

    it "fails validation with no amount" do
      receipt = Receipt.new(amount: nil)
      receipt.should have(2).error_on(:amount)
      receipt.errors[:amount].should == ["can't be blank", "is not a number"]
    end

    it "fails validation with no currency" do
      receipt = Receipt.new
      receipt.should have(1).error_on(:currency)
      receipt.errors[:currency].should == ["can't be blank"]
    end

    it "fails validation with no received_at" do
      receipt = Receipt.new
      receipt.should have(1).error_on(:received_at)
      receipt.errors[:received_at].should == ["can't be blank"]
    end

    it "fails validation with no payment_method" do
      receipt = Receipt.new
      receipt.should have(1).error_on(:payment_method)
      receipt.errors[:payment_method].should == ["can't be blank"]
    end
  end

  describe "format" do
    it "fails validation if amount is not a number" do
      receipt = Receipt.new(amount: "Something that is not a number")
      receipt.should have(1).error_on(:amount)
      receipt.errors[:amount].should == ["is not a number"]
    end

    it "fails validation if receipt_number is not a amount" do
      receipt = Receipt.new(receipt_number: "Something that is not a number")
      receipt.should have(1).error_on(:receipt_number)
      receipt.errors[:receipt_number].should == ["is not a number"]
    end
  end

  describe "uniqueness" do
    it "fails validation with a duplicate uuid" do
      receipt = FactoryGirl.create(:receipt)
      duplicate = Receipt.new(uuid: receipt.uuid)
      duplicate.should have(1).error_on(:uuid)
      duplicate.errors[:uuid].should == ["has already been taken"]
    end

    it "fails validation with a duplicate receipt_number" do # Within the receipt_numbers for THIS organisation
      receipt = FactoryGirl.create(:receipt)
      duplicate = Receipt.new(receipt_number: receipt.receipt_number, organisation_id: receipt.organisation_id)
      duplicate.should have(1).error_on(:receipt_number)
      duplicate.errors[:receipt_number].should == ["has already been taken"]
    end
  end
end
