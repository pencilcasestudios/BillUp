class Language < ActiveRecord::Base
  LANGUAGES = {
    # Translation                                                         # Database key. Ref: http://www.loc.gov/standards/iso639-2/php/code_list.php
    I18n.t("models.language.languages.eng")                =>             "English",
  }

  def self.random_language
    LANGUAGES[LANGUAGES.to_a[rand LANGUAGES.size].first]
  end
end
