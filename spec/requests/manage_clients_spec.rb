require 'spec_helper'
require 'authentication_helper'

describe "Client management" do
  describe "with no subdomain" do
    # Clients exist in relation to Organisations
    describe "requesting /clients" do
      it "should not be successful" do
        get "/clients"
        response.status.should_not be(200)
      end
    end
  end

  describe "with a subdomain" do    
    describe "and not signed in" do
    end

    describe "and signed in" do
    end
  end
end
