# Ref: http://stackoverflow.com/questions/3524127/exception-notification-gem-and-rails-3
Rails.application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[BillUp Exception] ",
  :sender_address => %{"BillUp Exceptions Notifier" <exceptions+no-reply@billup.net>},
  :exception_recipients => %w{exceptions_group@billup.net}
