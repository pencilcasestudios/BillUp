require "support/authentication_helper"

describe "User management" do
  describe "when not signed in" do
    # users#index
    describe "requesting /users" do
      it "redirects to the sign up page" do
        visit users_path

        current_path.should eq(sign_in_path)
        page.should have_content(I18n.t("views.sessions.new.title"))  # As a result of the redirect to sign_up_path
      end
    end

    # users#new
    describe "requesting sign up" do
      it "allows the user to sign up" do
        expected_delayed_jobs = Delayed::Job.count + 1
        visit sign_up_path

        fill_in I18n.t("views.users._form.labels.name"), with: "Silumesii Maboshe"

        email = "silumesii@example.com"
        fill_in I18n.t("views.users._form.labels.email"), with: email

        cell_phone_number = PhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: cell_phone_number

        password = "password"
        fill_in I18n.t("views.users._form.labels.username"), with: "silumesii"
        fill_in I18n.t("views.users._form.labels.password"), with: password
        fill_in I18n.t("views.users._form.labels.password_confirmation"), with: password

        select I18n.t("models.language.names.eng"), from: I18n.t("views.users._form.labels.language")
        select "(GMT+02:00) Africa/Lusaka", from: I18n.t("views.users._form.labels.time_zone")

        captcha = User.connection.execute("select * from simple_captcha_data").last
        fill_in "user_captcha", with: captcha["value"]

        check I18n.t("views.users._form.labels.terms_of_use")

        click_button I18n.t("helpers.submit.user.create")

        current_path.should eq(sign_in_path)
        page.should have_content(I18n.t("controllers.users_controller.actions.create.success"))

        #last_email.to.should include(email)      
        #last_email.subject.should eq(I18n.t("mailers.emailer.registration_confirmation.subject", application_name: I18n.t("application.name")))      
        expected_delayed_jobs.should eq(Delayed::Job.count)
      end
    end
    
    # users#show
    describe "requesting /account_settings" do
      it "redirects to the sign up page" do
        visit account_settings_path
        page.should have_content(I18n.t("views.sessions.new.title"))  # As a result of the redirect to sign_up_path
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
        page.should have_content(I18n.t("views.welcome.signed_in_home.title"))  # As a result of the redirect to the root_path
      end
    end

    # users#show
    describe "requesting /users/:user_id" do
      it "redirects to /account_settings" do
        visit user_path(@current_user)
        
        current_path.should eq(account_settings_path)
        page.should have_content(I18n.t("views.users.edit.title"))  # As a result of the redirect to account_settings_path
      end
    end

    # users#new
    describe "requesting sign up" do
      it "redirects to the root_path" do
        visit sign_up_path
        page.should have_content(I18n.t("views.welcome.signed_in_home.title"))  # As a result of the redirect to the root_path
      end
    end

    # users#edit
    describe "requesting /account_settings" do
      it "displays the user's settings" do
        visit account_settings_path
        page.should have_content(I18n.t("views.users.edit.title"))  # As a result of the redirect to account_settings_path
      end

      it "allows the user to edit their name" do
        visit account_settings_path
        page.should have_content(I18n.t("views.users.edit.title"))  # As a result of the redirect to account_settings_path

        updated_field = "#{Time.now.strftime("%s")} " + @current_user.name
        fill_in I18n.t("views.users._form.labels.name"), with: updated_field

        click_button I18n.t("helpers.submit.user.update")

        current_path.should eq(account_settings_path)
        
        page.should have_content(I18n.t("controllers.users_controller.actions.update.success"))
        find_field(I18n.t("views.users._form.labels.name")).value.should eq(updated_field)
      end

      it "allows the user to edit their email" do
        visit account_settings_path
        page.should have_content(I18n.t("views.users.edit.title"))  # As a result of the redirect to account_settings_path

        updated_field = "#{Time.now.strftime("%s")}" + @current_user.email
        fill_in I18n.t("views.users._form.labels.email"), with: updated_field

        click_button I18n.t("helpers.submit.user.update")

        current_path.should eq(account_settings_path)
        
        page.should have_content(I18n.t("controllers.users_controller.actions.update.success"))
        find_field(I18n.t("views.users._form.labels.email")).value.should eq(updated_field)
      end

      it "allows the user to edit their cell_phone_number" do
        visit account_settings_path
        page.should have_content(I18n.t("views.users.edit.title"))  # As a result of the redirect to account_settings_path

        updated_field = PhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: updated_field

        click_button I18n.t("helpers.submit.user.update")

        current_path.should eq(account_settings_path)
        
        page.should have_content(I18n.t("controllers.users_controller.actions.update.success"))
        find_field(I18n.t("views.users._form.labels.cell_phone_number")).value.should eq(updated_field)
      end
    end

    describe "trying to access another user's account settings" do
      it "fails" do
        @other_user = FactoryGirl.create(:user)
        
        visit user_path(@other_user)
        
        current_path.should eq(root_path)
        page.should have_content(I18n.t("controllers.application_controller.flash.access_denied"))
      end
    end
  end
end
