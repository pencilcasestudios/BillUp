class Payment < ActiveRecord::Base
  TYPES = {
    # Translation                                                     # Database key
    I18n.t("models.payment.types.airtel_money")  =>                   "airtel_money",
    I18n.t("models.payment.types.bank_transfer") =>                   "bank_transfer",
    I18n.t("models.payment.types.cash")          =>                   "cash",
    I18n.t("models.payment.types.cheque")        =>                   "cheque",
    I18n.t("models.payment.types.debit_card")    =>                   "debit_card",
    I18n.t("models.payment.types.mtn_money")     =>                   "mtn_money",
  }
end
