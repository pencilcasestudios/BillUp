def setup_organisations
  organisation = (rand 15) + 1
  @organisations = []
  organisation.times do
    @organisations << FactoryGirl.create(:organisation)
    @organisations.last.members << @current_user
  end
end

def get_a_random_organisation_for_the_current_user
  @organisation = @organisations[rand @organisations.size]

  visit root_path
  click_link @organisation.name

  current_path.should eq(root_path)
  page.should have_content(I18n.t("views.organisations.show.title", organisation_name: @organisation.name))
end
