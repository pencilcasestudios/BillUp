require 'spec_helper'

describe "Assets" do

  # In lib/assets/stylesheets/
  describe "lib/assets/stylesheets/" do

    it "has stylesheet assets" do
      get "/assets/bootstrap.css"
      response.status.should be(200)
    end
  end

  # In lib/assets/javascripts/
  describe "lib/assets/javascripts/" do

    it "has javascript assets" do
      get "/assets/bootstrap-alerts.js"
      response.status.should be(200)

      get "/assets/bootstrap-dropdown.js"
      response.status.should be(200)

      get "/assets/bootstrap-modal.js"
      response.status.should be(200)

      get "/assets/bootstrap-popover.js"
      response.status.should be(200)

      get "/assets/bootstrap-scrollspy.js"
      response.status.should be(200)

      get "/assets/bootstrap-tabs.js"
      response.status.should be(200)

      get "/assets/bootstrap-twipsy.js"
      response.status.should be(200)
    end
  end

  # In app/assets/stylesheets/
  describe "app/assets/stylesheets/" do

    it "has stylesheet assets" do
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
