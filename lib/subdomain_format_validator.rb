# Ref: http://stackoverflow.com/questions/5196640/regular-expression-for-valid-subdomain-in-ruby
class SubdomainFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /^[a-z\d]+([-_][a-z\d]+)*$/i
      object.errors[attribute] << (options[:message] || "is not formatted properly")
    end
  end
end
