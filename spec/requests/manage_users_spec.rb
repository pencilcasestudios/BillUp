require 'spec_helper'
require 'authentication_helper'

describe "User management" do
  describe "when not signed in" do
    describe "requesting /users" do
      it "redirects to the sign up page" do
        get users_path
        response.should redirect_to(sign_up_path)
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end

    describe "requesting /users" do
      it "redirects to the root path" do
        visit users_path
        page.should have_content(I18n.t("views.welcome.signed_in_home.title"))  # As a result of the redirect to root_path
      end
    end

    describe "requesting sign up" do
      it "redirects to the root path" do
        visit sign_up_path
        page.should have_content(I18n.t("views.welcome.signed_in_home.title"))  # As a result of the redirect to root_path
      end
    end
  end
end
