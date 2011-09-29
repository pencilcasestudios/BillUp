require 'spec_helper'
require 'authentication_helper'

describe "Session management" do
  # User not signed in
  describe "when not signed in" do
    # sessions#index
    describe "requesting /sessions" do
      it "redirects to the sign in page" do
        visit sessions_path
        page.should have_content(I18n.t('views.sessions.new.title'))  # As a result of the redirect to sign_in_path
      end
    end

    # sessions#new
    describe "requesting to sign in" do
      it "displays the sign in page" do
        get sign_in_path
        response.status.should be(200)
      end
    end

    # sessions#destroy
    describe "requesting sign out" do
      it "redirects to the sign in page" do
        visit sign_out_path
        page.should have_content(I18n.t('views.sessions.new.title'))  # As a result of the redirect to sign_in_path
      end
    end
  end




  # User signed in
  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end

    # sessions#index
    describe "requesting /sessions" do
      it "redirects to the root path" do
        visit sessions_path
        page.should have_content(@current_user.name)                            # As a result of the redirect to root_path
        page.should have_content(I18n.t("views.welcome.signed_in_home.title"))  # As a result of the redirect to root_path
      end
    end

    # sessions#new
    describe "requesting to sign in" do
      it "redirects to the root path" do
        visit sign_in_path
        page.should have_content(@current_user.name)                            # As a result of the redirect to root_path
        page.should have_content(I18n.t("views.welcome.signed_in_home.title"))  # As a result of the redirect to root_path
      end
    end

    # sessions#destroy
    describe "requesting to sign out" do
      it "allows sign out" do
        visit sign_out_path
        page.should have_content(I18n.t('controllers.sessions_controller.actions.destroy.success'))
      end
    end
  end




  # Test sign in with various credentials
  describe "Sign in" do
    it "allows an existing user to sign in with an email and password" do
      sign_in_with_email

      current_path.should eq(root_path)
      page.should have_content(I18n.t('controllers.sessions_controller.actions.create.success'))
      page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
      page.should have_content(I18n.t('views.welcome.signed_in_home.title'))
    end

    it "allows an existing user to sign in with a username and password" do
      sign_in_with_username

      current_path.should eq(root_path)
      page.should have_content(I18n.t('controllers.sessions_controller.actions.create.success'))
      page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
      page.should have_content(I18n.t('views.welcome.signed_in_home.title'))
    end

    it "allows an existing user to sign in with a cell_phone_number and password" do
      sign_in_with_cell_phone_number

      current_path.should eq(root_path)
      page.should have_content(I18n.t('controllers.sessions_controller.actions.create.success'))
      page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
      page.should have_content(I18n.t('views.welcome.signed_in_home.title'))
    end

    it "rejects a form with no fields" do
      visit sign_in_path

      click_button I18n.t('views.sessions.new.form.button.submit')

      current_path.should eq(sessions_path)
      page.should have_content(I18n.t('controllers.sessions_controller.actions.create.error'))
      page.should_not have_content(I18n.t('views.application._navigation.link.sign_out'))
    end

    it "rejects a user with invalid sign in credentials" do
      user = Factory(:user)  
      visit sign_in_path
      fill_in I18n.t('views.sessions.new.form.label.identifier'), :with => user.email
      fill_in I18n.t('views.sessions.new.form.label.password'), :with => Time.now # Incorrect password

      click_button I18n.t('views.sessions.new.form.button.submit')

      current_path.should eq(sessions_path)
      page.should have_content(I18n.t('controllers.sessions_controller.actions.create.error'))
      page.should_not have_content(I18n.t('views.application._navigation.link.sign_out'))
    end
  end
end
