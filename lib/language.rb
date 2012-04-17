class Language < ActiveRecord::Base
  NAMES = {
    # Translation                                                         # Database key. Ref: http://www.loc.gov/standards/iso639-2/php/code_list.php
    I18n.t("models.language.names.eng")                =>                 "English",
  }

  def self.random_language
    NAMES[NAMES.to_a[rand NAMES.size].first]
  end
end
