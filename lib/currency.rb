class Currency < ActiveRecord::Base
  CODES = {
    I18n.t("models.currency.codes.zmk") => "zmk",
    I18n.t("models.currency.codes.usd") => "usd",
    I18n.t("models.currency.codes.cad") => "cad",
    I18n.t("models.currency.codes.gbp") => "gbp",
    I18n.t("models.currency.codes.eur") => "eur",
  }
  
  def self.random_currency_code
    CODES[CODES.to_a[rand CODES.size].first]
  end
end
