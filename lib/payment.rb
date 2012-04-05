class Payment < ActiveRecord::Base
  METHODS = {
    I18n.t("models.payment.methods.airtel_money")  => "airtel_money",
    I18n.t("models.payment.methods.bank_transfer") => "bank_transfer",
    I18n.t("models.payment.methods.cash")          => "cash",
    I18n.t("models.payment.methods.cash_deposit")  => "cash_deposit",
    I18n.t("models.payment.methods.cheque")        => "cheque",
    I18n.t("models.payment.methods.debit_card")    => "debit_card",
    I18n.t("models.payment.methods.mtn_money")     => "mtn_money",
  }

  def self.random_payment_method
    METHODS[METHODS.to_a[rand METHODS.size].first]
  end
end
