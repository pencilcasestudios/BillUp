require "support/authentication_helper"

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
        @organisations = []
        @organisations[0] = FactoryGirl.create(:organisation)
        @organisations[0].members << @current_user
        @organisations[1] = FactoryGirl.create(:organisation)
        @organisations[1].members << @current_user
        @organisations[2] = FactoryGirl.create(:organisation)
        @organisations[2].members << @current_user
        @organisations[3] = FactoryGirl.create(:organisation)
        @organisations[3].members << @current_user
      end

      describe "requesting /organisations" do
        it "redirects to the sign in page" do

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
        organisation = @organisations[rand @organisations.size]

        visit organisations_path
        click_link organisation.name
        
        current_path.should eq(root_path)
        #request.subdomain.should eq(organisation.subdomain)
        page.should have_content(I18n.t("views.organisations.show.title", :organisation_name => organisation.name))
        page.should have_content(I18n.t("views.organisations._organisation_has_no_clients.copy.p1").truncate(80).gsub("...", ""))        
      end
    end

    describe "is not a member of an organisation" do
    end

    describe "is a member of an organisation" do
    end
  end
end
