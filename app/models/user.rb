class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :email, :password, on: :create
  validates :email, uniqueness: true
  has_secure_password

  enum role: [:guest, :manager, :admin]
  enum approval: [:declined, :waiting, :approved]

  has_many :user_games
  has_many :games, :through => :user_games


  def approved?
    approval == "approved"
  end
end