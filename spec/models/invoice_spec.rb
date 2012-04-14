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

    it "fails validation with no state" do
      invoice = Invoice.new
      invoice.should have(1).error_on(:state)
      invoice.errors[:state].should == ["can't be blank"]
    end

    it "fails validation with no uuid" do
      invoice = Invoice.new
      invoice.should have(1).error_on(:uuid)
      invoice.errors[:uuid].should == ["can't be blank"]
    end
  end
  
  describe "format" do
    it "fails validation if invoice_number is not a number" do
      invoice = Invoice.new(invoice_number: "Something that is not a number")
      invoice.should have(1).error_on(:invoice_number)
      invoice.errors[:invoice_number].should == ["is not a number"]
    end
  end

  describe "uniqueness" do
    it "fails validation with a duplicate invoice_number" do # Within the invoice_numbers for THIS organisation
      invoice = FactoryGirl.create(:invoice)
      duplicate = Invoice.new(invoice_number: invoice.invoice_number, organisation_id: invoice.organisation_id)
      duplicate.should have(1).error_on(:invoice_number)
      duplicate.errors[:invoice_number].should == ["has already been taken"]
    end

    it "fails validation with a duplicate uuid" do
      invoice = FactoryGirl.create(:invoice)
      duplicate = Invoice.new(uuid: invoice.uuid)
      duplicate.should have(1).error_on(:uuid)
      duplicate.errors[:uuid].should == ["has already been taken"]
    end
  end

  describe "range" do
    it "fails validation if invoice_number is less than 0" do
      invoice = Invoice.new(invoice_number: -1)
      invoice.should have(1).error_on(:invoice_number)
      invoice.errors[:invoice_number].should == ["must be greater than 0"]
    end
  end
end
