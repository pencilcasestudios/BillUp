def sign_in_with_username
  @current_user = Factory(:user)  

  visit sign_in_path

  fill_in I18n.t('views.sessions.new.form.label.identifier'), :with => @current_user.username
  fill_in I18n.t('views.sessions.new.form.label.password'), :with => AppConfig.test_user_password

  click_button I18n.t('views.sessions.new.form.button.submit')
  page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
  page.should have_content(@current_user.name)
end

def sign_in_with_email
  @current_user = Factory(:user)  

  visit sign_in_path

  fill_in I18n.t('views.sessions.new.form.label.identifier'), :with => @current_user.email
  fill_in I18n.t('views.sessions.new.form.label.password'), :with => AppConfig.test_user_password

  click_button I18n.t('views.sessions.new.form.button.submit')
  page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
  page.should have_content(@current_user.name)
end

def sign_in_with_cell_phone_number
  @current_user = Factory(:user)  

  visit sign_in_path

  fill_in I18n.t('views.sessions.new.form.label.identifier'), :with => @current_user.cell_phone_number
  fill_in I18n.t('views.sessions.new.form.label.password'), :with => AppConfig.test_user_password

  click_button I18n.t('views.sessions.new.form.button.submit')
  page.should have_content(I18n.t('views.application._navigation.link.sign_out'))
  page.should have_content(@current_user.name)
end
