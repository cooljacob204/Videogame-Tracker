class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :email, :password, on: :create
  has_secure_password

  enum role: [:guest, :manager, :admin]
end