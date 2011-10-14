require 'spec_helper'

describe LineItem do
  describe "presence" do
    it "fails validation with no description" do
      line_item = LineItem.new
      line_item.should have(1).error_on(:description)
      line_item.errors[:description].should == ["can't be blank"]
    end

    it "fails validation with no invoice_id" do
      line_item = LineItem.new
      line_item.should have(2).error_on(:invoice_id)
      line_item.errors[:invoice_id].should == ["can't be blank", "is not a number"]
    end

    it "quantity is 0 by default" do
      line_item = LineItem.new
      line_item.should have(0).error_on(:quantity)
      line_item.quantity.should eq(0)
    end

    it "fails validation with no quantity" do
      line_item = LineItem.new(quantity: nil)
      line_item.should have(2).error_on(:quantity)
      line_item.errors[:quantity].should == ["can't be blank", "is not a number"]
    end

    it "fails validation with no currency" do
      line_item = LineItem.new
      line_item.should have(1).error_on(:currency)
      line_item.errors[:currency].should == ["can't be blank"]
    end

    it "unit_price is 0 by default" do
      line_item = LineItem.new
      line_item.should have(0).error_on(:unit_price)
      line_item.unit_price.should eq(0)
    end

    it "fails validation with no unit_price" do
      line_item = LineItem.new(unit_price: nil)
      line_item.should have(2).error_on(:unit_price)
      line_item.errors[:unit_price].should == ["can't be blank", "is not a number"]
    end
  end

  describe "format" do
    it "fails validation if invoice_id is not a number" do
      line_item = LineItem.new(invoice_id: "Something that is not a number")
      line_item.should have(1).error_on(:invoice_id)
      line_item.errors[:invoice_id].should == ["is not a number"]
    end

    it "fails validation if quantity is not a number" do
      line_item = LineItem.new(quantity: "Something that is not a number")
      line_item.should have(1).error_on(:quantity)
      line_item.errors[:quantity].should == ["is not a number"]
    end

    it "fails validation if unit_price is not a number" do
      line_item = LineItem.new(unit_price: "Something that is not a number")
      line_item.should have(1).error_on(:unit_price)
      line_item.errors[:unit_price].should == ["is not a number"]
    end
  end
end
