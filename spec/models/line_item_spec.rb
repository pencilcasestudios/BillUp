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

    it "fails validation with no quantity" do
      line_item = LineItem.new
      line_item.should have(2).error_on(:quantity)
      line_item.errors[:quantity].should == ["can't be blank", "is not a number"]
    end

    it "fails validation with no units" do
      line_item = LineItem.new
      line_item.should have(1).error_on(:units)
      line_item.errors[:units].should == ["can't be blank"]
    end

    it "fails validation with no unit_price" do
      line_item = LineItem.new
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
