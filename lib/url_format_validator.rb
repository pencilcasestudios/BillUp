class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ URI::regexp(%w(http https)) # Ref: http://mbleigh.com/2009/02/18/quick-tip-rails-url-validation.html
      object.errors[attribute] << (options[:message] || "is not formatted properly")
    end
  end
end
