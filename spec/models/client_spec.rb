describe Client do
  describe "presence" do
    it "fails validation with no name" do
      client = Client.new
      client.should have(1).error_on(:name)
      client.errors[:name].should == ["can't be blank"]
    end
  end
  
  describe "uniqueness" do
    it "fails validation with a duplicate name for the same organisation" do
      client = FactoryGirl.create(:client)
      duplicate = Client.new(name: client.name, organisation: client.organisation)
      duplicate.should have(1).error_on(:name)
      duplicate.errors[:name].should == ["has already been taken"]
    end
  end
end
