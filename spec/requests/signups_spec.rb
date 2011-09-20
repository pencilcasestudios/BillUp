require 'spec_helper'

describe "SignUps" do
  it "allows a new user to sign up" do
    visit sign_up_path

    fill_in I18n.t('views.users.new.form.label.name'), :with => 'Silumesii Maboshe'

    fill_in I18n.t('views.users.new.form.label.email'), :with => 'silumesii@example.com'
    fill_in I18n.t('views.users.new.form.label.cell_phone_number'), :with => '097 519 1837'
    
    password = 'password'
    fill_in I18n.t('views.users.new.form.label.username'), :with => 'silumesii'
    fill_in I18n.t('views.users.new.form.label.password'), :with => password
    fill_in I18n.t('views.users.new.form.label.password_confirmation'), :with => password
    
    select I18n.t('views.users.new.form.selector.language.english'), :from => I18n.t('views.users.new.form.label.language')
    select "(GMT+02:00) Harare", :from => I18n.t('views.users.new.form.label.time_zone')
    
    check I18n.t('views.users.new.form.label.terms_of_use')

    click_button I18n.t('views.users.new.form.button.submit')
    
    current_path.should eq(sign_in_path)
    page.should have_content(I18n.t('controllers.users_controller.actions.create.success'))
    
  end
end
