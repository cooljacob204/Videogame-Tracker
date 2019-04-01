class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :email, :password
  has_secure_password
end