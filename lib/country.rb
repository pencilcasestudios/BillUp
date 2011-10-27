class Country < ActiveRecord::Base
  NAMES = {
    # Translation                                                   # Database key
    I18n.t("models.country.names.canada")      =>                   "Canada",
    I18n.t("models.country.names.netherlands") =>                   "Netherlands",
    I18n.t("models.country.names.tanzania")    =>                   "Tanzania",
    I18n.t("models.country.names.zambia")      =>                   "Zambia",
  }
end
