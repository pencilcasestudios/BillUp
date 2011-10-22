require 'spec_helper'

describe "SignUps" do
  it "allows a new user to sign up" do
    visit sign_up_path

    fill_in I18n.t('views.users._form.labels.name'), with: 'Silumesii Maboshe'

    fill_in I18n.t('views.users._form.labels.email'), with: 'silumesii@example.com'

    cell_phone_number = [["+",""][rand 2],"#{'%010d' % (rand 1000000000000)}"].join.strip
    fill_in I18n.t('views.users._form.labels.cell_phone_number'), with: cell_phone_number
    
    password = 'password'
    fill_in I18n.t('views.users._form.labels.username'), with: 'silumesii'
    fill_in I18n.t('views.users._form.labels.password'), with: password
    fill_in I18n.t('views.users._form.labels.password_confirmation'), with: password
    
    select I18n.t("models.language.names.eng"), from: I18n.t('views.users._form.labels.language')
    select "(GMT+02:00) Africa/Lusaka", from: I18n.t('views.users._form.labels.time_zone')
    
    check I18n.t('views.users._form.labels.terms_of_use')

    click_button I18n.t("helpers.submit.user.create")
    
    current_path.should eq(sign_in_path)
    page.should have_content(I18n.t('controllers.users_controller.actions.create.success'))
    
  end
end
