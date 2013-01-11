require "support/authentication_helper"
require "support/organisation_helper"
require "support/client_helper"

describe "Client management" do
  describe "when not signed in" do
    # clients#index
    describe "requesting /clients" do
      it "fails" do
        # TODO rewrite this test using visit
        #get clients_path
        #response.status.should_not be(200)
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_username
    end

    describe "without an organisation" do
      it "requesting /clients fails" do
        # TODO rewrite this test using visit
        #get clients_path
        #response.status.should_not be(200)
      end
    end

    describe "with organisations" do
      before(:each) do
        setup_organisations
        setup_clients
      end

      it "allows a client to be created" do
        get_a_random_organisation_for_the_current_user

        within ".sidebar" do
          click_link I18n.t("views.organisations.show.links.new_client")
        end

        current_path.should eq(new_client_path)

        page.should have_content(I18n.t("views.clients.new.title"))

        # Client
        client_name = "Brand New Fake Client #{Time.now.strftime("%Y%m%d%H%M%S")}"
        fill_in I18n.t("views.clients._form.labels.name"), with: client_name

        # Address
        fill_in I18n.t("views.addresses._form.labels.label"), with: "Fake"
        fill_in I18n.t("views.addresses._form.labels.street"), with: "123 Fake Street"
        fill_in I18n.t("views.addresses._form.labels.town"), with: "Fake Town"
        select Country.random_country, from: I18n.t("views.addresses._form.labels.country")

        click_button I18n.t("helpers.submit.create", :model => "Client")

        page.should have_content(I18n.t("controllers.clients_controller.actions.create.success"))
        page.should have_content(client_name)
      end

      it "allows access to the list of clients for an organisation" do
        get_a_random_organisation_for_the_current_user

        page.should have_content(I18n.t("views.organisations.show.links.clients"))

        within ".sidebar" do
          click_link I18n.t("views.organisations.show.links.clients")
        end

        current_path.should eq(clients_path)
        page.should have_content(I18n.t("views.clients.index.title"))
        @organisation.clients.blank?.should_not eq(true)
        @organisation.clients.each do |client|
          page.should have_content(client.name)
        end
      end

      it "allows a client page to be displayed" do
        get_a_random_organisation_for_the_current_user

        page.should have_content(I18n.t("views.organisations.show.links.clients"))

        within ".sidebar" do
          click_link I18n.t("views.organisations.show.links.clients")
        end

        current_path.should eq(clients_path)
        page.should have_content(I18n.t("views.clients.index.title"))
        @organisation.clients.blank?.should_not eq(true)
        @organisation.clients.each do |client|
          page.should have_content(client.name)
        end

        client = @organisation.random_client

        click_link client.name

        current_path.should eq(client_path(client))

        within ".client_name" do
          page.should have_content(client.name)
        end
      end

      it "allows a client to be updated" do
        get_a_random_organisation_for_the_current_user

        page.should have_content(I18n.t("views.organisations.show.links.clients"))

        within ".sidebar" do
          click_link I18n.t("views.organisations.show.links.clients")
        end

        current_path.should eq(clients_path)
        page.should have_content(I18n.t("views.clients.index.title"))
        @organisation.clients.blank?.should_not eq(true)
        @organisation.clients.each do |client|
          page.should have_content(client.name)
        end

        client = @organisation.random_client

        click_link client.name

        current_path.should eq(client_path(client))
        within ".client_name" do
          page.should have_content(client.name)
        end

        click_link I18n.t("views.clients.clickables.buttons.edit_this_client")

        current_path.should eq(edit_client_path(client))
        page.should have_content(I18n.t("views.clients.index.title"))

        new_field = "Brand New Name for #{client.name}"
        fill_in I18n.t("views.clients._form.labels.name"), with: new_field

        click_button I18n.t("helpers.submit.update", model: "Client")
        current_path.should eq(client_path(client))

        page.should have_content(I18n.t("controllers.clients_controller.actions.update.success"))
        within ".client_name" do
          page.should have_content(client.name)
          page.should have_content(new_field)
        end
      end
    end
  end
end
