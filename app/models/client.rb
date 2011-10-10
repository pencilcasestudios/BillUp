class Client < ActiveRecord::Base
  default_scope order("name")

  belongs_to :organisation

  validates :name, :presence => true, :uniqueness => {:scope => [:organisation_id]}
end
