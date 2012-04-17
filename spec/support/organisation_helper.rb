def setup_organisations
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

def get_a_random_organisation_for_the_current_user
  @organisation = @organisations[rand @organisations.size]

  visit root_path
  click_link @organisation.name
  
  current_path.should eq(root_path)
  #request.subdomain.should eq(organisation.subdomain)
  page.should have_content(I18n.t("views.organisations.show.title", :organisation_name => @organisation.name))
  page.should have_content(I18n.t("views.organisations._organisation_has_no_clients.copy.p1").truncate(80).gsub("...", ""))        
end