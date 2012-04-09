require "spec_helper"
require "authentication_helper"

describe "Session management" do
  describe "when not signed in" do
    describe "signing in with correct" do
      it "cell_phone_number and password succeeds" do
        sign_in_with_cell_phone_number
      end
      it "email and password succeeds" do
        sign_in_with_email
      end
      it "username and password succeeds" do
        sign_in_with_username
      end
    end
  end
  
  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end
    
    
  end
end
