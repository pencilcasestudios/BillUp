class Emailer < ActionMailer::Base
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => t("mailers.emailer.registration_confirmation.subject"), :from => AppConfig.email_user_name)
  end
end
