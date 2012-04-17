require "support/authentication_helper"
require "support/organisation_helper"

describe "Organisation management" do
  # Guest session
  describe "when not signed in" do
    # organisation#index
    describe "requesting /organisations" do
      it "redirects to the sign in page" do
        visit organisations_path

        current_path.should eq(sign_in_path)
        page.should have_content(I18n.t("views.sessions.new.title"))
      end
    end

    # organisation#new
    describe "requesting /organisations/new" do
      it "redirects to the sign in page" do
        visit new_organisation_path

        current_path.should eq(sign_in_path)
        page.should have_content(I18n.t("views.sessions.new.title"))  # As a result of the direct
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end

    it "allows the User to create an" do
      organisations_at_start = @current_user.organisations.size

      visit new_organisation_path

      # Organisation
      organisation_name = "Fake Widgets Since #{Time.now.strftime("%Y%m%d%H%M%S")}"
      fill_in I18n.t("views.organisations._form.labels.name"), with: organisation_name
      fill_in I18n.t("views.organisations._form.labels.subdomain"), with: organisation_name.downcase.strip.gsub(" ", "")

      # Address
      fill_in I18n.t("views.addresses._form.labels.label"), with: "Fake"
      fill_in I18n.t("views.addresses._form.labels.street"), with: "123 Fake Street"
      fill_in I18n.t("views.addresses._form.labels.town"), with: "Fake Town"
      select I18n.t("models.country.names.zambia"), from: I18n.t("views.addresses._form.labels.country")

      click_button I18n.t("helpers.submit.create", :model => "Organisation")

      @current_user.organisations.size.should eq(organisations_at_start + 1)

      page.should have_content(I18n.t("controllers.organisations_controller.actions.create.success"))
      page.should have_content(I18n.t("views.welcome.signed_in_home._user_has_organisations.title"))
      page.should have_content(organisation_name)
    end

    describe "with no organisations" do
      describe "requesting /organisations" do
        it "redirects to the sign in page" do
          visit organisations_path

          current_path.should eq(root_path)
          page.should have_content(I18n.t("views.welcome.signed_in_home.title"))
          page.should have_content(I18n.t("views.welcome.signed_in_home._user_has_no_organisations.title"))
        end
      end
    end

    describe "with organisations" do
      before(:each) do
        setup_organisations
      end

      describe "requesting /organisations" do
        it "redirects to the home page for the current user" do

          visit organisations_path

          current_path.should eq(root_path)
          page.should have_content(I18n.t("views.welcome.signed_in_home.title"))
          page.should have_content(I18n.t("views.welcome.signed_in_home._user_has_organisations.title"))

          @organisations.each do |organisation|
            page.should have_content(organisation.name)
          end
          
          @current_user.organisations.size.should eq(@organisations.size)
        end
      end
      
      it "allows access to an organisation" do
        get_a_random_organisation_for_the_current_user
      end
      
      describe "updating an organisation's" do
        before(:each) do
          get_a_random_organisation_for_the_current_user

          page.should have_content(I18n.t("views.organisations.show.links.organisation_settings"))
        
          click_link I18n.t("views.organisations.show.links.organisation_settings")
        
          current_path.should eq(edit_organisation_path(@organisation))
        
          page.should have_content(I18n.t("views.organisations.edit.title", organisation_name: @organisation.name))
        end

        it "name succeeds" do
          new_field = "A new name for #{@organisation.name}"
          fill_in I18n.t("views.organisations._form.labels.name"), with: new_field

          click_button I18n.t("helpers.submit.update", model: "Organisation")

          page.should have_content(I18n.t("controllers.organisations_controller.actions.update.success"))
          page.should have_content(I18n.t("views.organisations.show.title", organisation_name: new_field))
        end

        #it "URL succeeds" do
        #  new_field = "newsubdomain"
        #  fill_in I18n.t("views.organisations._form.labels.subdomain"), with: new_field
        #
        #  click_button I18n.t("helpers.submit.update", model: "Organisation")
        #
        #  page.should have_content(I18n.t("controllers.organisations_controller.actions.update.success"))
        #  page.should have_content(I18n.t("views.organisations.show.title", organisation_name: new_name))
        #end
        #
        #it "URL fails if it is already taken" do
        #  new_name = "A new name for #{@organisation.name}"
        #  fill_in I18n.t("views.organisations._form.labels.name"), with: new_name
        #
        #  click_button I18n.t("helpers.submit.update", model: "Organisation")
        #
        #  page.should have_content(I18n.t("controllers.organisations_controller.actions.update.success"))
        #  page.should have_content(I18n.t("views.organisations.show.title", organisation_name: new_name))
        #end
      end
    end

    describe "is not a member of an organisation" do
    end

    describe "is a member of an organisation" do
    end
  end
end
