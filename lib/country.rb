class Country < ActiveRecord::Base
  NAMES = {
    # Translation                                                             # Database key
    I18n.t("models.country.names.canada")                =>                   "Canada",
    I18n.t("models.country.names.zambia")                =>                   "Zambia",
  }
end
