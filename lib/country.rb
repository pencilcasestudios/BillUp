class Country < ActiveRecord::Base
  COUNTRIES = {
    # Translation                                                   # Database key
    I18n.t("models.country.countries.canada")      =>               "Canada",
    I18n.t("models.country.countries.netherlands") =>               "Netherlands",
    I18n.t("models.country.countries.tanzania")    =>               "Tanzania",
    I18n.t("models.country.countries.zambia")      =>               "Zambia",
  }

  def self.random_country
    COUNTRIES[COUNTRIES.to_a[rand COUNTRIES.size].first]
  end
end
