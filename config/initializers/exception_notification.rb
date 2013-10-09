# Ref: http://stackoverflow.com/questions/3524127/exception-notification-gem-and-rails-3
# Ref: https://github.com/smartinez87/exception_notification
Rails.application.config.middleware.use ExceptionNotification::Rack, :email => {
	:email_prefix => "[BillUp Exception] ",
	:sender_address => %{"BillUp Exceptions Notifier" <exceptions+no-reply@billup.net>},
	:exception_recipients => %w{exceptions_group@billup.net}
}
