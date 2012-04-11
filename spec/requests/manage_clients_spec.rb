require "authentication_helper"

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
  end
end
