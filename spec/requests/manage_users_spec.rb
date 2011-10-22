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

    # users#show
    describe "requesting /account_settings" do
      it "redirects to the sign up page" do
        visit account_settings_path
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

    # users#edit
    describe "requesting /account_settings" do
      it "displays the user's settings" do
        visit account_settings_path
        page.should have_content(I18n.t('views.users.edit.title'))  # As a result of the redirect to account_settings_path
      end

      it "allows the user to edit their name" do
        visit account_settings_path
        page.should have_content(I18n.t('views.users.edit.title'))  # As a result of the redirect to account_settings_path

        updated_field = "#{Time.now.strftime("%s")} " + @current_user.name
        fill_in I18n.t('views.users._form.labels.name'), with: updated_field

        click_button I18n.t('views.users._form.button.submit')

        current_path.should eq(account_settings_path)
        
        page.should have_content(I18n.t('controllers.users_controller.actions.update.success'))
        find_field(I18n.t('views.users._form.labels.name')).value.should eq(updated_field)
      end

      it "allows the user to edit their email" do
        visit account_settings_path
        page.should have_content(I18n.t('views.users.edit.title'))  # As a result of the redirect to account_settings_path

        updated_field = "#{Time.now.strftime("%s")}" + @current_user.email
        fill_in I18n.t('views.users._form.labels.email'), with: updated_field

        click_button I18n.t('views.users._form.button.submit')

        current_path.should eq(account_settings_path)
        
        page.should have_content(I18n.t('controllers.users_controller.actions.update.success'))
        find_field(I18n.t('views.users._form.labels.email')).value.should eq(updated_field)
      end

      it "allows the user to edit their cell_phone_number" do
        visit account_settings_path
        page.should have_content(I18n.t('views.users.edit.title'))  # As a result of the redirect to account_settings_path

        updated_field = [["+",""][rand 2],"#{'%010d' % (rand 1000000000000)}"].join.strip
        fill_in I18n.t('views.users._form.labels.cell_phone_number'), with: updated_field

        click_button I18n.t('views.users._form.button.submit')

        current_path.should eq(account_settings_path)
        
        page.should have_content(I18n.t('controllers.users_controller.actions.update.success'))
        find_field(I18n.t('views.users._form.labels.cell_phone_number')).value.should eq(updated_field)
      end
    end
  end
end
