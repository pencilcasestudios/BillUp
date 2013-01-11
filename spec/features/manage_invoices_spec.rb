require "support/authentication_helper"

describe "Invoice management" do
  describe "when not signed in" do
    # inovices#index
    describe "requesting /inovices" do
      it "fails" do
        # TODO - Rewrite with 'visit'
        #get invoices_path
        #response.status.should_not be(200)
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end

    describe "without organisations" do
    end

    describe "without clients" do
    end

    describe "with clients" do
    end
  end
end
