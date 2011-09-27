class User < ActiveRecord::Base
  has_secure_password

  validates :cell_phone_number, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true, :email_format => true  
  validates :name, :presence => true
  validates :language, :presence => true
  validates :time_zone, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :terms_of_use, :acceptance => true, :on => :create

  has_many :memberships
  has_many :organisations, :through => :memberships

  attr_accessor :terms_of_use
end
