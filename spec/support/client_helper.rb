require "support/organisation_helper"

def setup_clients
  @organisations.size.should_not eq(0)
  
  @organisations.each do |organisation|
    organisation.clients.blank?.should eq(true)
    client = (rand 15) + 1
    client.times do
      c = FactoryGirl.create(:client)
      #c.organisation = organisation
      organisation.clients << c
    end
    organisation.clients.blank?.should eq(false)
  end
end
