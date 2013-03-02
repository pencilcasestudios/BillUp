class Country < ActiveRecord::Base
  COUNTRIES = {
    I18n.t("models.country.countries.australia")    =>               "Australia",
    I18n.t("models.country.countries.canada")       =>               "Canada",
    I18n.t("models.country.countries.netherlands")  =>               "Netherlands",
    I18n.t("models.country.countries.south_africa") =>               "South Africa",
    I18n.t("models.country.countries.tanzania")     =>               "Tanzania",
    I18n.t("models.country.countries.zambia")       =>               "Zambia",
  }

  def self.random_country
    COUNTRIES[COUNTRIES.to_a[rand COUNTRIES.size].first]
  end
end
