require "authentication_helper"

describe "Session management" do
  describe "when not signed in" do
    describe "signing in with correct" do
      it "cell_phone_number and password succeeds" do
        sign_in_with_cell_phone_number
      end
      
      it "email and password succeeds" do
        sign_in_with_email
      end
      
      it "username and password succeeds" do
        sign_in_with_username
      end
    end
    
    describe "requesting sign out" do
      it "fails" do
        visit sign_out_path

        current_path.should eq(sign_in_path)

        page.should have_content(I18n.t("controllers.application_controller.flash.sign_in_required"))
        page.should_not have_content(I18n.t("views.application._navigation.links.sign_out"))
      end
    end
    
    describe "requesting /sessions" do
      it "redirects to /sign_in" do
        visit sessions_path

        current_path.should eq(sign_in_path) # As a result of the redirect
      end
    end
  end

  describe "when signed in" do
    describe "with cell_phone_number" do
      before(:each) do
        sign_in_with_cell_phone_number
      end

      describe "requesting sign in" do
        it "fails" do
          visit sign_in_path

          # Redirect to the root_path
          page.should have_content(I18n.t("controllers.application_controller.flash.sign_out_required"))
          page.should have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should have_content(@current_user.name)
        end
      end

      describe "requesting sign out" do
        it "succeeds" do
          visit sign_out_path

          current_path.should eq(sign_in_path)

          page.should have_content(I18n.t("controllers.sessions_controller.actions.destroy.success"))
          page.should_not have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should_not have_content(@current_user.name)
        end
      end

      describe "requesting /sessions" do
        it "redirects to /sign_in" do
          visit sessions_path

          current_path.should eq(root_path)

          # Redirect to the root_path
          page.should have_content(I18n.t("controllers.application_controller.flash.sign_out_required"))
          page.should have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should have_content(@current_user.name)
        end
      end
    end

    describe "with email" do
      before(:each) do
        sign_in_with_email
      end

      describe "requesting sign in" do
        it "fails" do
          visit sign_in_path

          # Redirect to the root_path
          page.should have_content(I18n.t("controllers.application_controller.flash.sign_out_required"))
          page.should have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should have_content(@current_user.name)
        end
      end

      describe "requesting sign out" do
        it "succeeds" do
          visit sign_out_path

          current_path.should eq(sign_in_path)

          page.should have_content(I18n.t("controllers.sessions_controller.actions.destroy.success"))
          page.should_not have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should_not have_content(@current_user.name)
        end
      end

      describe "requesting /sessions" do
        it "redirects to /sign_in" do
          visit sessions_path

          current_path.should eq(root_path)

          # Redirect to the root_path
          page.should have_content(I18n.t("controllers.application_controller.flash.sign_out_required"))
          page.should have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should have_content(@current_user.name)
        end
      end
    end

    describe "with username" do
      before(:each) do
        sign_in_with_username
      end

      describe "requesting sign in" do
        it "fails" do
          visit sign_in_path

          # Redirect to the root_path
          page.should have_content(I18n.t("controllers.application_controller.flash.sign_out_required"))
          page.should have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should have_content(@current_user.name)
        end
      end

      describe "requesting sign out" do
        it "succeeds" do
          visit sign_out_path

          current_path.should eq(sign_in_path)

          page.should have_content(I18n.t("controllers.sessions_controller.actions.destroy.success"))
          page.should_not have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should_not have_content(@current_user.name)
        end
      end

      describe "requesting /sessions" do
        it "redirects to /sign_in" do
          visit sessions_path

          current_path.should eq(root_path)

          # Redirect to the root_path
          page.should have_content(I18n.t("controllers.application_controller.flash.sign_out_required"))
          page.should have_content(I18n.t("views.application._navigation.links.sign_out"))
          page.should have_content(@current_user.name)
        end
      end
    end
  end
end
