require 'spec_helper'

describe "Sessions" do
  describe "Sign in" do
    it "allows an existing user to sign in with an email and password" do
      user = Factory(:user)  
      visit sign_in_path
      fill_in I18n.t('views.sessions.new.form.label.identifier'), :with => user.email
      fill_in I18n.t('views.sessions.new.form.label.password'), :with => "secret"

      click_button I18n.t('views.sessions.new.form.button.submit')

      current_path.should eq(root_path)
      page.should have_content(I18n.t('controllers.sessions_controller.actions.create.success'))
      page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
    end

    it "allows an existing user to sign in with a username and password" do
      user = Factory(:user)  
      visit sign_in_path
      fill_in I18n.t('views.sessions.new.form.label.identifier'), :with => user.username
      fill_in I18n.t('views.sessions.new.form.label.password'), :with => "secret"

      click_button I18n.t('views.sessions.new.form.button.submit')

      current_path.should eq(root_path)
      page.should have_content(I18n.t('controllers.sessions_controller.actions.create.success'))
      page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
    end

    it "allows an existing user to sign in with a cell_phone_number and password" do
      user = Factory(:user)  
      visit sign_in_path
      fill_in I18n.t('views.sessions.new.form.label.identifier'), :with => user.cell_phone_number
      fill_in I18n.t('views.sessions.new.form.label.password'), :with => "secret"

      click_button I18n.t('views.sessions.new.form.button.submit')

      current_path.should eq(root_path)
      page.should have_content(I18n.t('controllers.sessions_controller.actions.create.success'))
      page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
    end

    it "allows an existing user to sign in and out" do
      user = Factory(:user)  
      visit sign_in_path
      fill_in I18n.t('views.sessions.new.form.label.identifier'), :with => user.email
      fill_in I18n.t('views.sessions.new.form.label.password'), :with => "secret"

      click_button I18n.t('views.sessions.new.form.button.submit')

      current_path.should eq(root_path)
      page.should have_content(I18n.t('views.application._navigation.link.sign_out'))

      click_link I18n.t('views.application._navigation.link.sign_out')

      current_path.should eq(sign_in_path)
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
