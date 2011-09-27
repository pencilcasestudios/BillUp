require 'spec_helper'
require 'authentication_helper'

describe "Organisation management" do
  describe "when not signed in" do
    it "denies the User to access the organisation creation page" do
      get new_organisation_path
      response.status.should_not be(200)
      response.should redirect_to(sign_in_path)
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
      fill_in I18n.t('views.organisations.new.form.label.name'), :with => organisation_name
      fill_in I18n.t('views.organisations.new.form.label.subdomain'), :with => organisation_name.downcase.strip.gsub(" ", "")

      click_button I18n.t('views.organisations.new.form.button.submit')

      @current_user.organisations.size.should eq(organisations_at_start + 1)

      page.should have_content(I18n.t('controllers.organisations_controller.actions.create.success'))
      page.should have_content(I18n.t("views.welcome.signed_in_home.body.header.organisations_you_can_invoice_for"))
      page.should have_content(organisation_name)
    end
  end
end
