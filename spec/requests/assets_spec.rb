require 'spec_helper'

describe "Assets" do

  # In vendor/assets/stylesheets/
  describe "vendor/assets/stylesheets/" do

    # Bootstrap stylesheets
    describe "bootstrap/" do
      it "has Bootstrap stylesheet assets" do
        get "/assets/bootstrap/bootstrap.css"
        response.status.should be(200)
      end
    end
  end

  # In vendor/assets/javascripts/
  describe "vendor/assets/javascripts/" do

    # Bootstrap javascripts
    describe "bootstrap/" do
      it "has Bootrap javascript assets" do
        get "/assets/bootstrap/bootstrap-alerts.js"
        response.status.should be(200)

        get "/assets/bootstrap/bootstrap-dropdown.js"
        response.status.should be(200)

        get "/assets/bootstrap/bootstrap-modal.js"
        response.status.should be(200)

        get "/assets/bootstrap/bootstrap-popover.js"
        response.status.should be(200)

        get "/assets/bootstrap/bootstrap-scrollspy.js"
        response.status.should be(200)

        get "/assets/bootstrap/bootstrap-tabs.js"
        response.status.should be(200)

        get "/assets/bootstrap/bootstrap-twipsy.js"
        response.status.should be(200)
      end
    end
  end

  # In app/assets/stylesheets/
  describe "app/assets/stylesheets/" do

    it "has stylesheet assets" do
      get "/assets/organisations.css"
      response.status.should be(200)

      get "/assets/sessions.css"
      response.status.should be(200)

      get "/assets/styles.css"
      response.status.should be(200)

      get "/assets/users.css"
      response.status.should be(200)

      get "/assets/welcome.css"
      response.status.should be(200)
    end
  end


  # In app/assets/images/
  describe "app/assets/images/" do

    it "has image assets" do
      get "/assets/apple-touch-icon.png"
      response.status.should be(200)

      get "/assets/apple-touch-icon-72x72.png"
      response.status.should be(200)

      get "/assets/apple-touch-icon-114x114.png"
      response.status.should be(200)

      get "/assets/favicon.ico"
      response.status.should be(200)
    end
  end
end
