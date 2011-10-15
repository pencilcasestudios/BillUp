class Country < ActiveRecord::Base
  NAME = {
    # Translation                                                             # Database key
    I18n.t("models.country.names.zambia")                =>                   "Zambia",
  }
end
