require 'spec_helper'

describe Client do
  describe "presence" do
    it "fails validation with no name" do
      client = Client.new
      client.should have(1).error_on(:name)
      client.errors[:name].should == ["can't be blank"]
    end
  end
  
  describe "uniqueness" do
    it "fails validation with a duplicate name" do
      # TODO
    end
  end
end
