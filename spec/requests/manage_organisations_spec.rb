require 'spec_helper'
require 'authentication_helper'

describe "Organisation management" do
  # Guest session
  describe "when not signed in" do
    # organisation#new
    describe "requesting /organisations/new" do
      it "redirects to the sign in page" do
        visit new_organisation_path
        page.should have_content(I18n.t('views.sessions.new.title'))  # As a result of the direct
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end

    it "allows the User to access the organisation creation page" do
      organisations_at_start = @current_user.organisations.size

      visit new_organisation_path

      organisation_name = "Widgets Since #{Time.now.strftime("%Y%m%d%H%M%S")}"
      fill_in I18n.t('views.organisations.new.form.label.name'), with: organisation_name
      fill_in I18n.t('views.organisations.new.form.label.subdomain'), with: organisation_name.downcase.strip.gsub(" ", "")

      click_button I18n.t('views.organisations.new.form.button.submit')

      @current_user.organisations.size.should eq(organisations_at_start + 1)

      page.should have_content(I18n.t('controllers.organisations_controller.actions.create.success'))
      page.should have_content(I18n.t("views.welcome.signed_in_home._user_has_organisations.title"))
      page.should have_content(organisation_name)
    end
    
    describe "is not a member of an organisation" do
    end

    describe "is a member of an organisation" do
    end
  end
end
