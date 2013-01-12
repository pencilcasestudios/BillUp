class Currency < ActiveRecord::Base
  CODES = {
    I18n.t("models.currency.codes.cad") => "cad",
    I18n.t("models.currency.codes.eur") => "eur",
    I18n.t("models.currency.codes.gbp") => "gbp",
    I18n.t("models.currency.codes.usd") => "usd",
    I18n.t("models.currency.codes.zar") => "zar",
    I18n.t("models.currency.codes.zmk") => "zmk",
    I18n.t("models.currency.codes.zmw") => "zmw",
  }

  def self.random_currency_code
    CODES[CODES.to_a[rand CODES.size].first]
  end
end
