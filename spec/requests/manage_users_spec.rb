require 'spec_helper'
require 'authentication_helper'

describe "User management" do
  describe "when not signed in" do
    # users#index
    describe "requesting /users" do
      it "redirects to the sign up page" do
        visit users_path
        page.should have_content(I18n.t('views.sessions.new.title'))  # As a result of the redirect to sign_up_path
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end

    # users#index
    describe "requesting /users" do
      it "redirects to the root_path" do
        visit users_path
        page.should have_content(I18n.t('views.welcome.signed_in_home.title'))  # As a result of the redirect to the root_path
      end
    end

    # users#new
    describe "requesting sign up" do
      it "redirects to the root_path" do
        visit sign_up_path
        page.should have_content(I18n.t('views.welcome.signed_in_home.title'))  # As a result of the redirect to the root_path
      end
    end
  end
end
