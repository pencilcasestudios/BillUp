require "support/authentication_helper"

describe "Client management" do
  describe "when not signed in" do
    # clients#index
    describe "requesting /clients without a subdomain" do
      it "fails" do
        get clients_path

        response.status.should_not be(200)
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end

    describe "without an organisation (sub-domain)" do
      it "fails" do
        get clients_path

        response.status.should_not be(200)
      end
    end

    describe "with an organisation (sub-domain)" do
    end
  end
end
