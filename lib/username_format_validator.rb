# 3 to 30 characters, numbers, letters, dashes, underscores
class UsernameFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /^[a-z0-9_-]{3,30}$/i
      object.errors[attribute] << (options[:message] || "is not formatted properly")
    end
  end
end
