class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :email, :password, on: :create
  validates :email, uniqueness: true
  has_secure_password

  enum role: [:guest, :manager, :admin]
  enum approval: [:declined, :waiting, :approved]

  has_many :user_games
  has_many :games, :through => :user_games
  has_many :created_games, foreign_key: "user_id", class_name: "Game"


  def approved?
    approval == "approved"
  end

  def cleaned
    OpenStruct.new(
      :firstname => firstname,
      :lastname => lastname,
      :email => email,
      :role => role
    )
  end

  def self.null_user
    OpenStruct.new(
      :firstname => nil,
      :lastname => nil,
      :email => nil,
      :role => 'guest'
    )
  end
end